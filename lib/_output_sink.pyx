cdef enum CallbackSinkArgEnum:
    CBSA_Integer = 1
    CBSA_Bytes
    CBSA_Latin1

cdef callback_sink_arg_for_name(name):
    return _generic_id_for_name(_CallbackSinkArgFormat, name)

cdef type _CallbackSinkArgFormat

class _CallbackSinkArgFormat(IntEnum):
    for_name = staticmethod(callback_sink_arg_for_name)

    integer = CallbackSinkArgEnum.CBSA_Integer
    bytes = CallbackSinkArgEnum.CBSA_Bytes
    latin1 = CallbackSinkArgEnum.CBSA_Latin1

CallbackSinkArgFormat = _CallbackSinkArgFormat


@no_gc
@auto_pickle(False)
cdef class OutputSink:
    cdef TidyOutputSink tidy_sink

    def __cinit__(OutputSink self):
        self.tidy_sink.sinkData = <void*> self
        self.tidy_sink.putByte = NULL

    def __nonzero__(OutputSink self):
        return (
            (self.tidy_sink.sinkData is <void*> self) and
            (self.tidy_sink.putByte is not NULL)
        )


@final
@no_gc
@auto_pickle(False)
cdef class CallbackSink(OutputSink):
    cdef public object callback
    cdef public object exception

    def __cinit__(CallbackSink self, callback=None, arg=_CallbackSinkArgFormat.integer):
        cdef long fmt

        fmt = PyLong_AsLong(callback_sink_arg_for_name(arg))

        self.callback = callback

        if fmt is CallbackSinkArgEnum.CBSA_Integer:
            self.tidy_sink.putByte = CallbackSink.put_byte_integer
        elif fmt is CallbackSinkArgEnum.CBSA_Bytes:
            self.tidy_sink.putByte = CallbackSink.put_byte_bytes
        elif fmt is CallbackSinkArgEnum.CBSA_Latin1:
            self.tidy_sink.putByte = CallbackSink.put_byte_latin1
        else:
            raise RuntimeError

    def __nonzero__(CallbackSink self):
        return (self.callback is not None) and (self.exception is None)

    cdef void _put_byte_integer(CallbackSink self, byte bt):
        if self.exception is None:
            try:
                CallFunction(<PyObject*> self.callback, b'B', <unsigned char> bt)
            except BaseException as ex:
                self.exception = ex
                raise

    cdef void _put_byte_bytes(CallbackSink self, byte bt):
        cdef object datum
        if self.exception is None:
            datum = PyBytes_FromStringAndSize(<char*> &bt, 1)
            try:
                CallFunction(<PyObject*> self.callback, b'O', <PyObject*> datum)
            except BaseException as ex:
                self.exception = ex
                raise

    cdef void _put_byte_latin(CallbackSink self, byte bt):
        cdef object datum
        if self.exception is None:
            datum = PyUnicode_DecodeLatin1(<char*> &bt, 1, b'replace')
            try:
                CallFunction(<PyObject*> self.callback, b'O', <PyObject*> datum)
            except BaseException as ex:
                self.exception = ex
                raise

    @staticmethod
    cdef void put_byte_integer(void *sinkData, byte bt) noexcept nogil:
        with gil:
            (<CallbackSink> sinkData)._put_byte_integer(bt)

    @staticmethod
    cdef void put_byte_bytes(void *sinkData, byte bt) noexcept nogil:
        with gil:
            (<CallbackSink> sinkData)._put_byte_bytes(bt)

    @staticmethod
    cdef void put_byte_latin1(void *sinkData, byte bt) noexcept nogil:
        with gil:
            (<CallbackSink> sinkData)._put_byte_latin(bt)


@final
@no_gc
@auto_pickle(False)
cdef class FiledescriptorSink(OutputSink):
    cdef public int fd
    cdef public boolean closefd
    cdef Py_ssize_t filled, empty
    cdef bytearray buffer

    def __cinit__(FiledescriptorSink self):
        self.fd = -1
        self.closefd = False
        self.filled = 0
        self.empty = 0

    def __init__(FiledescriptorSink self, int fd=-1, *, boolean closefd=False, Py_ssize_t buffering=8192):
        if buffering <= 0:
            raise ValueError

        self.fd = fd
        self.closefd = closefd
        self.tidy_sink.putByte = FiledescriptorSink.put_byte
        self.filled = 0
        self.empty = buffering
        self.buffer = PyByteArray_FromStringAndSize(NULL, buffering)

    def __nonzero__(FiledescriptorSink self):
        return self.fd >= 0

    def __enter__(FiledescriptorSink self):
        return self

    def __exit__(FiledescriptorSink self, typ, value, traceback):
        self.close()

    cpdef int close(FiledescriptorSink self):
        cdef int fd = self.fd
        cdef ssize_t result

        if fd >= 0:
            with nogil:
                result = self._flush()
        else:
            result = 0

        self.fd = -1
        if self.closefd and (fd >= 0):
            close(fd)

        if result < 0:
            RaiseErrOccurred()

        return fd

    def __dealloc__(FiledescriptorSink self):
        self.close()

    def flush(FiledescriptorSink self):
        cdef int result
        with nogil:
            result = self._flush()
        if result < 0:
            RaiseErrOccurred()

    cdef ssize_t _flush(FiledescriptorSink self) noexcept nogil:
        cdef ssize_t result
        cdef Py_ssize_t filled = self.filled
        cdef int fd = self.fd
        cdef char *position = PyByteArray_AS_STRING(self.buffer)

        self.empty = PyByteArray_GET_SIZE(self.buffer)
        self.filled = 0

        if fd >= 0:
            while filled > 0:
                result = write(fd, position, filled)

                if result <= 0:
                    result = -errno
                    with gil:
                        ErrSetFromErrno(OSError)
                    return result

                filled -= result
                position += result

        return 0

    @staticmethod
    cdef void put_byte(void *sinkData, byte bt) noexcept nogil:
        cdef Py_ssize_t *empty = &(<FiledescriptorSink> sinkData).empty
        cdef Py_ssize_t *filled = &(<FiledescriptorSink> sinkData).filled
        cdef char *buf = PyByteArray_AS_STRING((<FiledescriptorSink> sinkData).buffer)

        if empty[0] <= <Py_ssize_t> 0:
            if (<FiledescriptorSink> sinkData)._flush() < 0:
                with gil:
                    ErrWriteUnraisable(<FiledescriptorSink> sinkData)
                return

            if empty[0] <= <Py_ssize_t> 0:
                return

        buf[filled[0]] = <char> bt
        filled[0] += 1
        empty[0] -= 1


@final
@no_gc
@auto_pickle(False)
cdef class VoidSink(OutputSink):
    def __cinit__(VoidSink self):
        self.tidy_sink.putByte = VoidSink.put_byte

    def __nonzero__(VoidSink self):
        return True

    def release(VoidSink self):
        '''
        Convenience function to appear like a :class:`pytidyhtml5.StringBuffer`.

        Returns
        -------
        None
            The result is always none.
        '''
        pass

    @staticmethod
    cdef void put_byte(void *sinkData, byte bt) noexcept nogil:
        pass
