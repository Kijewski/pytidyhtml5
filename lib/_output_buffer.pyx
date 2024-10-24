cdef Py_ssize_t STRIDES_1 = 1


cdef enum BufferTypeInSpe:
    Void = 1
    Utf8
    Bytes
    Ascii
    Latin1

cdef buffer_type_for_name(name):
    return _generic_id_for_name(_BufferType, name)

cdef type _BufferType

class _BufferType(IntEnum):
    for_name = staticmethod(buffer_type_for_name)

    void = BufferTypeInSpe.Void
    utf8 = BufferTypeInSpe.Utf8
    ascii = BufferTypeInSpe.Ascii
    latin1 = BufferTypeInSpe.Latin1
    bytes = BufferTypeInSpe.Bytes

BufferType = _BufferType


cdef Py_ssize_t START_ASCII = (<Py_ssize_t> <void*> &(<AsciiObject*> NULL).data[0])
cdef Py_ssize_t START_LATIN1 = (<Py_ssize_t> <void*> &(<Latin1Object*> NULL).data[0])
cdef Py_ssize_t START_BYTES = (<Py_ssize_t> <void*> &(<PyBytesObject*> NULL).ob_sval[0])


cdef inline Py_ssize_t buffer_type_start(int type):
    if type == BufferTypeInSpe.Ascii:
        return START_ASCII
    elif type == BufferTypeInSpe.Latin1:
        return START_LATIN1
    elif type == BufferTypeInSpe.Bytes:
        return START_BYTES
    else:
        return 0


@no_gc
@auto_pickle(False)
cdef class Buffer:
    cdef TidyBuffer tidy_buffer

    def __cinit__(Buffer self, *args):
        memset(&self.tidy_buffer, 0, sizeof(self.tidy_buffer))

    def __nonzero__(Buffer self):
        return self.tidy_buffer.allocator is not NULL

    def __dealloc__(Buffer self):
        if self.tidy_buffer.bp is not NULL:
            tidyBufFree(&self.tidy_buffer)


@final
@no_gc
@auto_pickle(False)
cdef class StringBuffer(Buffer):
    cdef readonly int type

    def __cinit__(StringBuffer self):
        self.type = 0

    def __init__(StringBuffer self, object type):
        cdef uint start
        cdef long int_type

        if type is None:
            int_type = BufferTypeInSpe.Void
        else:
            int_type = PyLong_FromLong(buffer_type_for_name(type))

        if int_type in (BufferTypeInSpe.Void, BufferTypeInSpe.Utf8):
            tidyBufInitWithAllocator(&self.tidy_buffer, &allocator_raw)
        elif int_type in (BufferTypeInSpe.Ascii, BufferTypeInSpe.Latin1, BufferTypeInSpe.Bytes):
            tidyBufInitWithAllocator(&self.tidy_buffer, &allocator_gil)

            start = buffer_type_start(int_type)
            tidyBufCheckAlloc(&self.tidy_buffer, start, 0)
            self.tidy_buffer.size = start
        else:
            raise ValueError

        self.type = int_type

    def __len__(StringBuffer self):
        if self:
            return self.tidy_buffer.size - buffer_type_start(self.type)
        else:
            return 0

    cpdef decode(StringBuffer self, const char *encoding, const char *errors = b'strict'):
        cdef object mem = PyMemoryView_FromObject(self)
        return PyUnicode_FromEncodedObject(mem, encoding, errors)

    cpdef release(StringBuffer self):
        cdef void *temp = NULL
        cdef Py_ssize_t start, length
        cdef object result
        cdef Py_ssize_t index
        cdef boolean is_ascii
        cdef signed char *s

        start = buffer_type_start(self.type)
        length = self.tidy_buffer.size - start
        if (length <= 0) or not self:
            if self.tidy_buffer.allocator is not NULL:
                tidyBufFree(&self.tidy_buffer)
                self.tidy_buffer.bp = NULL
                self.tidy_buffer.allocated = 0
                self.tidy_buffer.size = 0

            if self.type == BufferTypeInSpe.Bytes:
                result = PyBytes_FromStringAndSize(NULL, 0)
            elif self.type != BufferTypeInSpe.Void:
                result = PyUnicode_New(0, 0)
            else:
                result = None

        elif self.type == BufferTypeInSpe.Void:
            tidyBufFree(&self.tidy_buffer)
            result = None

        elif self.type == BufferTypeInSpe.Utf8:
            result = PyUnicode_DecodeUTF8(<char*> self.tidy_buffer.bp, length, b'replace')

        elif self.type == BufferTypeInSpe.Bytes:
            temp = ObjectRealloc(self.tidy_buffer.bp, self.tidy_buffer.size + 1)
            if temp is NULL:
                NoMemoryThrow()

            self.tidy_buffer.bp = <byte*> temp
            self.tidy_buffer.allocated = self.tidy_buffer.size + 1
            (<char*> self.tidy_buffer.bp)[self.tidy_buffer.size] = 0

            result = <object> <PyObject*> ObjectInitVar(
                (<PyVarObject*> self.tidy_buffer.bp), bytes, length,
            )
            reset_hash(<PyBytesObject*> result)

        else:
            s = &(<signed char*> self.tidy_buffer.bp)[start]
            is_ascii = True
            for index in range(length):
                if s[0] < 0:
                    break
                s += 1
            else:
                is_ascii = False

            if is_ascii == (self.type == BufferTypeInSpe.Ascii):
                # Shrink to fit
                temp = ObjectRealloc(self.tidy_buffer.bp, self.tidy_buffer.size + 1)
                if temp is NULL:
                    NoMemoryThrow()
                self.tidy_buffer.bp = <byte*> temp
            else:
                # The user supplied type does not match the actual data.
                if is_ascii:
                    # Convert to smaller type
                    memmove(
                        &(<char*> self.tidy_buffer.bp)[START_ASCII],
                        &(<char*> self.tidy_buffer.bp)[START_LATIN1],
                        length,
                    )

                    # shrink to fit
                    self.tidy_buffer.size -= START_LATIN1 - START_ASCII
                    temp = ObjectRealloc(self.tidy_buffer.bp, self.tidy_buffer.size + 1)
                    if temp is NULL:
                        NoMemoryThrow()
                    self.tidy_buffer.bp = <byte*> temp
                else:
                    # Shrink or grow to fit
                    self.tidy_buffer.size += START_LATIN1 - START_ASCII
                    temp = ObjectRealloc(self.tidy_buffer.bp, self.tidy_buffer.size + 1)
                    if temp is NULL:
                        NoMemoryThrow()
                    self.tidy_buffer.bp = <byte*> temp

                    # Convert to bigger type
                    memmove(
                        &(<char*> self.tidy_buffer.bp)[START_LATIN1],
                        &(<char*> self.tidy_buffer.bp)[START_ASCII],
                        length,
                    )

            # If the data is pure ASCII, then the ASCII flag must be set.
            # If the ASCII flag is set, then the structure must be PyASCIIObject, not PyCompactUnicodeObject.

            self.tidy_buffer.allocated = self.tidy_buffer.size + 1
            (<char*> self.tidy_buffer.bp)[self.tidy_buffer.size] = 0

            result = ObjectInit(<PyObject*> self.tidy_buffer.bp, unicode)

            (<PyASCIIObject*> result).length = length
            reset_hash(<PyASCIIObject*> result)
            reset_wstr(<PyASCIIObject*> result)
            (<PyASCIIObject*> result).state.interned = SSTATE_NOT_INTERNED
            (<PyASCIIObject*> result).state.kind = PyUnicode_1BYTE_KIND
            (<PyASCIIObject*> result).state.compact = True
            set_ready(<PyASCIIObject*> result)
            (<PyASCIIObject*> result).state.ascii = is_ascii

            if not is_ascii:
                (<PyCompactUnicodeObject*> result).utf8_length = 0
                (<PyCompactUnicodeObject*> result).utf8 = NULL
                reset_wstr_length(<PyASCIIObject*> result)

        self.tidy_buffer.allocator = NULL
        self.tidy_buffer.bp = NULL
        self.tidy_buffer.allocated = 0
        self.tidy_buffer.size = 0
        self.type = BufferTypeInSpe.Void

        return result

    def __getbuffer__(StringBuffer self, Py_buffer *view, int flags):
        if not self:
            raise RuntimeError('StringBuffer is already released')

        view.buf = (<char*> self.tidy_buffer.bp) + buffer_type_start(self.type)
        view.format = 'c'
        view.internal = NULL
        view.itemsize = 1
        view.len = self.tidy_buffer.size - buffer_type_start(self.type)
        view.ndim = 1
        view.obj = self
        view.readonly = 0
        view.shape = &view.len
        view.strides = &STRIDES_1
        view.suboffsets = NULL

    def append(StringBuffer self, data):
        cdef Py_buffer view

        if not self:
            raise RuntimeError('StringBuffer is already released')

        PyObject_GetBuffer(data, &view, PyBUF_CONTIG_RO)
        try:
            with nogil:
                tidyBufAppend(&self.tidy_buffer, view.buf, view.len)
        finally:
            PyBuffer_Release(&view)
