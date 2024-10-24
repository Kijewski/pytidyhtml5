cdef cppclass _GetEnum [T, V]:
    @staticmethod
    inline object _do(T elem, V fn(T) noexcept nogil, EnumCls):
        cdef V value
        cdef object result = None

        if <void*> elem is not NULL:
            value = fn(elem)
            result = PyLong_FromLong(<int> value)
            try:
                result = EnumCls(result)
            except Exception:
                pass

        return result


cdef cppclass _EnsureId [V]:
    @staticmethod
    inline Py_ssize_t _do(
        object name,
        V fn(ctmbstr) noexcept nogil,
        Py_ssize_t min_excl,
        Py_ssize_t max_excl,
    ) except -2:
        cdef char *string = NULL
        cdef Py_ssize_t length = 0
        cdef Py_ssize_t int_value

        if name is not None:
            if isinstance(name, int):
                int_value = <Py_ssize_t> name
            else:
                if isinstance(name, unicode):
                    string = <char*> PyUnicode_AsUTF8AndSize(name, &length)
                elif isinstance(name, bytes):
                    PyBytes_AsStringAndSize(name, &string, &length)
                else:
                    raise TypeError

                int_value = <Py_ssize_t> fn(string)

            if min_excl < int_value < max_excl:
                return int_value

        return -1


cdef object _generic_id_for_name(object cls, object name):
    if (name is None) or (type(name) is cls):
        return name
    elif isinstance(name, str):
        return getattr(cls, name, None)
    elif isinstance(name, int):
        try:
            return cls(name)
        except Exception:
            pass
