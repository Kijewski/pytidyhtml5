from cpython.object cimport PyObject
from libcpp cimport bool as boolean
from libcpp.limits cimport numeric_limits


cdef extern from '<cstdint>' namespace 'std' nogil:
    ctypedef unsigned char uint8_t
    ctypedef unsigned short uint16_t
    ctypedef unsigned long uint32_t
    ctypedef unsigned long long uint64_t

    ctypedef signed char int8_t
    ctypedef signed short int16_t
    ctypedef signed long int32_t
    ctypedef signed long long int64_t

    ctypedef unsigned long long uintptr_t


cdef extern from '<cstddef>' namespace 'std' nogil:
    ctypedef unsigned long size_t


cdef extern from '<utility>' namespace 'std' nogil:
    void swap[T](T&, T&)


cdef extern from '<cstring>' namespace 'std' nogil:
    size_t strlen(const char*)
    void memset(void*, int, size_t)
    void memmove(void*, const void*, size_t)


cdef extern from '<unistd.h>' nogil:
    ctypedef Py_ssize_t ssize_t

    ssize_t write(int fd, const void *buf, size_t count)
    int close(int fd)
    ssize_t read(int fd, void *buf, size_t count)


cdef extern from '<cerrno>' nogil:
    enum:
        errno


cdef extern from 'native.hpp' namespace 'PyTidyHtml5' nogil:
    const char VERSION[]
    const char LONGDESCRIPTION[]
    enum:
        VERSION_LENGTH
        LONGDESCRIPTION_LENGTH

    ctypedef unsigned char UChar3[3]
    UChar3 utf8_bom

    ctmbstr _text_fn  [T](T elem, ctmbstr fn(T) nogil)
    object _bool_fn   [T](T elem, Bool    fn(T) nogil)
    object _unicode_fn[T](T elem, ctmbstr fn(T) nogil)
    object _ulong_fn  [T](T elem, ulong   fn(T) nogil)
    object _uint_fn   [T](T elem, uint    fn(T) nogil)
    object _int_fn    [T](T elem, int     fn(T) nogil)

    ctmbstr _text_fn  [T, A](T elem, ctmbstr fn(T, A) nogil, A)
    object _bool_fn   [T, A](T elem, Bool    fn(T, A) nogil, A)
    object _unicode_fn[T, A](T elem, ctmbstr fn(T, A) nogil, A)
    object _ulong_fn  [T, A](T elem, ulong   fn(T, A) nogil, A)
    object _uint_fn   [T, A](T elem, uint    fn(T, A) nogil, A)
    object _int_fn    [T, A](T elem, int     fn(T, A) nogil, A)

    PyObject **ref_document[Cls](PyObject *self)
    Out _reinterpret_cast[Out, In](In ptr)
    int call_bool_fn_1(object fn, object arg1)
    void reset_hash[T](T *obj)
    void reset_wstr[T](T *obj)
    void reset_wstr_length[T](T *obj)
    void set_ready[T](T *obj)

    ctypedef boolean AlwaysTrue

ctypedef void *voidp
