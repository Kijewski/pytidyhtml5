@no_gc
@auto_pickle(False)
cdef class InputSource:
    cdef TidyInputSource input_source

    def __cinit__(InputSource self):
        memset(&self.input_source, 0, sizeof(self.input_source))
        self.input_source.sourceData = <void*> self

    def __nonzero__(InputSource self):
        return (
            (self.input_source.sourceData is <void*> self) and
            (self.input_source.getByte is not NULL) and
            (self.input_source.ungetByte is not NULL) and
            (self.input_source.eof is not NULL)
        )

    def get_byte(InputSource self):
        cdef int result
        if self:
            with nogil:
                result = tidyGetByte(&self.input_source)

            if result >= 0:
                return <unsigned char> result

    def unget_byte(InputSource self, unsigned char value):
        if self:
            with nogil:
                tidyUngetByte(&self.input_source, value)
            return True

    def is_eof(InputSource self):
        cdef Bool result
        if self:
            with nogil:
                result = tidyIsEOF(&self.input_source)
            return result is not no


cdef enum:
    FD_SOURCE_PUSHBACK_UNGET = 4


@final
@no_gc
@auto_pickle(False)
cdef class FiledescriptorSource(InputSource):
    cdef public int fd
    cdef public boolean closefd
    cdef Py_ssize_t pushback_length
    cdef Py_ssize_t pushback_remaining
    cdef bytearray buffer

    def __cinit__(FiledescriptorSource self):
        self.fd = -1
        self.closefd = False
        self.input_source.getByte = FiledescriptorSource._get_byte
        self.input_source.ungetByte = FiledescriptorSource._unget_byte
        self.input_source.eof = FiledescriptorSource._eof
        self.pushback_length = 0
        self.pushback_remaining = 0

    def __init__(FiledescriptorSource self, int fd=-1, *, boolean closefd=False, Py_ssize_t buffering=8192):
        if buffering <= 0:
            raise ValueError

        self.fd = fd
        self.closefd = closefd
        self.pushback_length = buffering
        self.buffer = PyByteArray_FromStringAndSize(NULL, FD_SOURCE_PUSHBACK_UNGET + buffering)

    def __nonzero__(FiledescriptorSource self):
        return self.fd >= 0

    cpdef int close(FiledescriptorSource self):
        cdef int fd = self.fd
        self.fd = -1
        if self.closefd and (fd >= 0):
            close(fd)
        return fd

    def __dealloc__(FiledescriptorSource self):
        self.close()

    def __enter__(FiledescriptorSource self):
        return self

    def __exit__(FiledescriptorSource self, typ, value, traceback):
        self.close()

    @staticmethod
    cdef int _get_byte(void *sourceData) noexcept nogil:
        return (<FiledescriptorSource> sourceData).get_byte()

    @staticmethod
    cdef void _unget_byte(void *sourceData, byte bt) noexcept nogil:
        (<FiledescriptorSource> sourceData).unget_byte(bt)

    @staticmethod
    cdef Bool _eof(void *sourceData) noexcept nogil:
        return (<FiledescriptorSource> sourceData).eof()

    cdef void unget_byte(FiledescriptorSource self, byte bt) noexcept nogil:
        cdef Py_ssize_t index

        self.pushback_remaining += 1
        index = self.pushback_length - self.pushback_remaining
        PyByteArray_AS_STRING(self.buffer)[index] = bt

    cdef int get_byte(FiledescriptorSource self) noexcept nogil:
        cdef uint8_t result
        cdef Py_ssize_t index
        cdef Py_ssize_t pushback_remaining = self.pushback_remaining

        if self.pushback_remaining < 0:
            if self.eof() is yes:
                return EndOfStream
            pushback_remaining = self.pushback_remaining

        index = self.pushback_length - pushback_remaining
        result = PyByteArray_AS_STRING(self.buffer)[index]
        self.pushback_remaining -= 1

        return result

    cdef Bool eof(FiledescriptorSource self) noexcept nogil:
        cdef ssize_t count

        if self.pushback_remaining > 0:
            return no

        if self.fd < 0:
            return yes

        count = read(
            self.fd,
            &PyByteArray_AS_STRING(self.buffer)[FD_SOURCE_PUSHBACK_UNGET],
            PyByteArray_GET_SIZE(self.buffer) - FD_SOURCE_PUSHBACK_UNGET,
        )
        if count <= 0:
            return yes

        self.pushback_length = count + FD_SOURCE_PUSHBACK_UNGET
        self.pushback_remaining = count
        return no
