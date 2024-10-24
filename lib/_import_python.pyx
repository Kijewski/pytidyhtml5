from cython import final, no_gc, auto_pickle
from cpython cimport Py_buffer, bool as PythonBool
from cpython.bool cimport PyBool_Check
from cpython.buffer cimport (
    PyObject_GetBuffer, PyBUF_CONTIG_RO, PyBuffer_Release,
)
from cpython.bytes cimport (
    PyBytes_AsStringAndSize, PyBytes_FromStringAndSize, PyBytes_Check,
    PyBytes_AsString,
)
from cpython.long cimport (
    PyLong_Check, PyLong_FromLong, PyLong_FromSsize_t, PyLong_AsLong,
)
from cpython.object cimport PyObject
from cpython.ref cimport Py_XINCREF, Py_XDECREF
from cpython.type cimport PyType_Check
from cpython.unicode cimport (
    PyUnicode_Check, PyUnicode_DecodeUTF8,
    PyUnicode_CompareWithASCIIString, PyUnicode_DecodeLatin1,
)


cdef extern from 'Python.h':
    ctypedef signed char Py_UCS1
    ctypedef signed short Py_UCS2
    ctypedef signed long Py_UCS4

    enum:
        PyUnicode_WCHAR_KIND
        PyUnicode_1BYTE_KIND
        PyUnicode_2BYTE_KIND
        PyUnicode_4BYTE_KIND

    int PyUnicode_READY(object o) except -1
    Py_ssize_t PyUnicode_GET_LENGTH(object o) noexcept nogil
    int PyUnicode_KIND(object o) noexcept nogil
    boolean PyUnicode_IS_ASCII(object) noexcept nogil
    Py_UCS1 *PyUnicode_1BYTE_DATA(object o) noexcept nogil
    Py_UCS2 *PyUnicode_2BYTE_DATA(object o) noexcept nogil
    Py_UCS4 *PyUnicode_4BYTE_DATA(object o) noexcept nogil
    void *PyUnicode_DATA(object o) noexcept nogil

    int PyDict_SetItemString(object p, const char *key, object val) except -1

    object PyUnicode_FromKindAndData(int kind, const void *buf, Py_ssize_t size)
    const char *PyUnicode_AsUTF8AndSize(object o, Py_ssize_t *size) except NULL
    object PyUnicode_New(Py_ssize_t size, Py_UCS4 maxchar)
    object PyUnicode_FromEncodedObject(object, const char *encoding, const char *errors)

    object PyMemoryView_FromObject(object)

    object PyByteArray_FromStringAndSize(const char*, Py_ssize_t)
    char *PyByteArray_AS_STRING(object) noexcept nogil
    Py_ssize_t PyByteArray_GET_SIZE(object) noexcept nogil

    ctypedef signed long Py_hash
    ctypedef signed short wchar_t

    enum:
        SSTATE_NOT_INTERNED
        SSTATE_INTERNED_MORTAL
        SSTATE_INTERNED_IMMORTAL

    ctypedef struct __ascii_object_state:
        uint8_t interned
        uint8_t kind
        boolean compact
        boolean ascii
        boolean ready

    ctypedef struct PyASCIIObject:
        Py_ssize_t length
        Py_hash hash
        __ascii_object_state state

    ctypedef struct PyCompactUnicodeObject:
        # PyASCIIObject
        Py_ssize_t utf8_length
        char *utf8

    ctypedef struct PyVarObject:
        pass

    ctypedef struct PyBytesObject:
        PyVarObject ob_base
        Py_hash ob_shash
        char ob_sval[1]

    void *ObjectRealloc 'PyObject_Realloc'(void *p, size_t n)
    PyVarObject *ObjectInitVar 'PyObject_InitVar'(PyVarObject *obj, type cls, Py_ssize_t size)
    object ObjectInit 'PyObject_INIT'(PyObject *obj, type cls)

    void *NoMemoryNoThrow 'PyErr_NoMemory'()
    AlwaysTrue NoMemoryThrow 'PyErr_NoMemory'()
    void ErrSetFromErrno 'PyErr_SetFromErrno'(object)
    void ErrWriteUnraisable 'PyErr_WriteUnraisable'(object)
    boolean RaiseIfErrOccurred 'PyErr_Occurred'() except True
    AlwaysTrue RaiseErrOccurred 'PyErr_Occurred'() except True

    void *PyMem_RawRealloc(void *p, size_t n) noexcept nogil

    PyObject *Py_None

    object CallFunction 'PyObject_CallFunction'(PyObject *cb, const char *format, ...)


ctypedef struct AsciiObject:
    PyASCIIObject base
    char data[1]


ctypedef struct Latin1Object:
    PyCompactUnicodeObject base
    char data[1]


cdef object Enum, IntEnum, EnumMeta, _EnumDict
from enum import Enum, IntEnum, EnumMeta, _EnumDict

cdef type Path, PurePath, WindowsPath, PosixPath
from pathlib import Path, PurePath, WindowsPath, PosixPath
