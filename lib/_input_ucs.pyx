ctypedef int8_t ascii_char

ctypedef fused Codepoint:
    ascii_char
    uint8_t
    uint16_t
    uint32_t


cdef inline int encode_utf8(SourceData *source_data, Codepoint v) noexcept nogil:
    cdef int32_t codepoint = v

    if (Codepoint is ascii_char) or (codepoint < 0x80):
        return <int> <int32_t> codepoint

    elif (Codepoint is uint8_t) or (codepoint < 0x800):
        source_data.sub_remaining = 1
        source_data.sub_string[0] = (codepoint & 0x3F) | 0x80
        return (codepoint >> 6) | 0xC0

    elif (Codepoint is uint16_t) or (codepoint < 0x10000):
        source_data.sub_remaining = 2
        source_data.sub_string[0] = (codepoint & 0x3F) | 0x80
        source_data.sub_string[1] = ((codepoint >> 6) & 0x3F) | 0x80
        return (codepoint>>12) | 0xE0

    elif (Codepoint is uint32_t) or (codepoint < 0x110000):
        source_data.sub_remaining = 3
        source_data.sub_string[0] = (codepoint & 0x3F) | 0x80
        source_data.sub_string[1] = ((codepoint >> 6) & 0x3F) | 0x80
        source_data.sub_string[2] = ((codepoint >> 12) & 0x3F) | 0x80
        return (codepoint >> 18) | 0xF0

    else:
        # impossible
        return <int> b' '


cdef inline int ucsGetByteFunc(SourceData *source_data, Codepoint *data) noexcept nogil:
    cdef int result

    result = source_data.pushback
    if result != <int> EndOfStream:
        source_data.pushback = <int> EndOfStream
    elif source_data.sub_remaining > 0:
        source_data.sub_remaining -= 1
        result = source_data.sub_string[source_data.sub_remaining]
    elif source_data.remaining > 0:
        result = encode_utf8(source_data, data[0])
        source_data.remaining -= 1
        source_data.string += sizeof(Codepoint)
    else:
        pass  # The input is exhausted

    return result


cdef int asciiGetByteFunc(void *sourceData_) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    return ucsGetByteFunc(source_data, <ascii_char*> source_data.string)


cdef int ucs1GetByteFunc(void *sourceData_) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    return ucsGetByteFunc(source_data, <uint8_t*> source_data.string)


cdef int ucs2GetByteFunc(void *sourceData_) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    return ucsGetByteFunc(source_data, <uint16_t*> source_data.string)


cdef int ucs4GetByteFunc(void *sourceData_) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    return ucsGetByteFunc(source_data, <uint32_t*> source_data.string)


ctypedef struct SourceData:
    Py_ssize_t remaining
    unsigned char *string

    int pushback
    uint8_t sub_remaining
    UChar3 sub_string


cdef void ungetByteFunc(void *sourceData_, byte bt) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    source_data.pushback = <int> <unsigned int> bt


cdef Bool eofFunc(void *sourceData_) noexcept nogil:
    cdef SourceData *source_data = <SourceData*> sourceData_
    if source_data.remaining != 0:
        return no
    elif source_data.pushback != <int> EndOfStream:
        return no
    elif source_data.sub_remaining > 0:
        return no
    else:
        return yes
