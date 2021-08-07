#pragma once

#include <array>
#include <utility>
#include <cstring>
#include "Python.h"

namespace PyTidyHtml5 {
inline namespace {

const char VERSION[] =
#   include "./VERSION.txt"
;

const char LONGDESCRIPTION[] =
#   include "./DESCRIPTION.txt"
;

const std::size_t VERSION_LENGTH = sizeof(VERSION) - 1;
const std::size_t LONGDESCRIPTION_LENGTH = sizeof(LONGDESCRIPTION) - 1;

using UChar3 = std::array<unsigned char, 3>;

constexpr const UChar3 utf8_bom{{0xBFu, 0xBBu, 0xEFu}};

template <class Type, class ...ArgsFn, class ...ArgsIn>
ctmbstr _text_fn(Type elem, ctmbstr fn(Type, ArgsFn...), ArgsIn &&...args) {
    return elem ? fn(elem, std::forward<ArgsIn>(args)...) : nullptr;
}

template <class Type, class ...ArgsFn, class ...ArgsIn>
PyObject *_bool_fn(Type elem, Bool fn(Type, ArgsFn...), ArgsIn &&...args) {
    PyObject *result;
    if (elem) {
        Bool outcome = fn(elem, std::forward<ArgsIn>(args)...);
        if (outcome != no) {
            result = Py_True;
        } else {
            result = Py_False;
        }
    } else {
        result = Py_None;
    }
    Py_INCREF(result);
    return result;
}

template <class Type, class ...ArgsFn, class ...ArgsIn>
PyObject *_unicode_fn(Type elem, ctmbstr fn(Type, ArgsFn...), ArgsIn &&...args) {
    ctmbstr text = _text_fn(elem, fn, std::forward<ArgsIn>(args)...);
    if (!text) {
        Py_RETURN_NONE;
    }

    std::size_t length = std::strlen(text);
    return PyUnicode_DecodeUTF8(text, length, "replace");
}

template <class Type, class ...ArgsFn, class ...ArgsIn>
PyObject *_ulong_fn(Type elem, ulong fn(Type, ArgsFn...), ArgsIn &&...args) {
    if (elem == nullptr) {
        Py_RETURN_NONE;
    }

    ulong result = fn(elem, std::forward<ArgsIn>(args)...);
    return PyLong_FromUnsignedLong(result);
}

template <class Type, class ...ArgsFn, class ...ArgsIn>
PyObject *_uint_fn(Type elem, uint fn(Type, ArgsFn...), ArgsIn &&...args) {
    if (elem == nullptr) {
        Py_RETURN_NONE;
    }

    uint result = fn(elem, std::forward<ArgsIn>(args)...);
    return PyLong_FromUnsignedLong(result);
}

template <class Type, class ...ArgsFn, class ...ArgsIn>
PyObject *_int_fn(Type elem, int fn(Type, ArgsFn...), ArgsIn &&...args) {
    if (elem == nullptr) {
        Py_RETURN_NONE;
    }

    int result = fn(elem, std::forward<ArgsIn>(args)...);
    return PyLong_FromUnsignedLong(result);
}

template <class Cls>
PyObject **ref_document(PyObject *self) {
    return (PyObject**) &((Cls) self)->document;
}

struct AlwaysTrue {
    inline AlwaysTrue() = default;
    inline ~AlwaysTrue() = default;

    inline AlwaysTrue(const AlwaysTrue&) = default;
    inline AlwaysTrue(AlwaysTrue&&) = default;
    inline AlwaysTrue &operator =(const AlwaysTrue&) = default;
    inline AlwaysTrue &operator =(AlwaysTrue&&) = default;

    template <class T>
    inline AlwaysTrue(T&&) : AlwaysTrue() {}

    template <class T>
    inline bool operator ==(T&&) const { return true; }

    inline operator bool () const { return true; }
};

template <class Out, class In>
Out _reinterpret_cast(In ptr) {
    return reinterpret_cast<Out>(ptr);
}

int call_bool_fn_1(PyObject *fn, PyObject *arg1) {
    PyObject *result = PyObject_CallFunction(fn, "O", arg1);
    if (!result) {
        PyErr_WriteUnraisable(fn);
        PyErr_Clear();
        return -1;
    }

    int truthy = PyObject_IsTrue(result);
    if (truthy < 0) {
        PyErr_WriteUnraisable(result);
        PyErr_Clear();
        Py_DECREF(result);
    }

    return truthy;
}


template <typename T>
struct has_ob_shash {
    template <typename C> static std::uint8_t test(decltype(&C::ob_shash)) ;
    template <typename C> static std::uint64_t test(...);
    enum { value = sizeof(test<T>(0)) == sizeof(std::uint8_t) };
};

template <typename T>
struct has_hash {
    template <typename C> static std::uint8_t test(decltype(&C::hash)) ;
    template <typename C> static std::uint64_t test(...);
    enum { value = sizeof(test<T>(0)) == sizeof(std::uint8_t) };
};

template<class T, bool ob_shash = has_ob_shash<T>::value, bool hash = has_hash<T>::value>
struct ResetHash_;

template<class T>
struct ResetHash_ <T, true, false> {
    static inline void reset(T *obj) {
        obj->ob_shash = -1;  // CPython: str
    }
};

template<class T>
struct ResetHash_ <T, false, true> {
    static inline void reset(T *obj) {
        obj->hash = -1;  // CPython: bytes
    }
};

template<class T>
struct ResetHash_ <T, false, false> {
    static inline void reset(T *obj) {
        (void) 0;  // PyPy
    }
};

template <class T>
static inline void reset_hash(T *obj) {
    ResetHash_<T>::reset(obj);
}

}
}
