cdef extern from 'tidyplatform.h' nogil:
    ctypedef unsigned char byte
    ctypedef unsigned int uint
    ctypedef unsigned long ulong

    ctypedef uint tchar
    ctypedef char tmbchar

    ctypedef tmbchar *tmbstr
    ctypedef const tmbchar *ctmbstr

    ctypedef enum Bool:
        no
        yes

    ctypedef struct __TidyIterator
    ctypedef __TidyIterator *TidyIterator
