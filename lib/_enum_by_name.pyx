cdef cppclass _GetEnum [T, V]:
    @staticmethod
    inline object _do(T elem, V fn(T) nogil, EnumCls):
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
        V fn(ctmbstr) nogil,
        Py_ssize_t min_excl,
        Py_ssize_t max_excl,
    ) except -2:
        cdef char *string
        cdef Py_ssize_t length
        cdef Py_ssize_t int_value

        if name is not None:
            if isinstance(name, int):
                int_value = <Py_ssize_t> name
            else:
                if isinstance(name, unicode):
                    string = PyUnicode_AsUTF8AndSize(name, &length)
                elif isinstance(name, bytes):
                    PyBytes_AsStringAndSize(name, &string, &length)
                else:
                    raise TypeError

                int_value = <Py_ssize_t> fn(string)

            if min_excl < int_value < max_excl:
                return int_value

        return -1


cdef object _generic_id_for_name(cls, name):
    if (name is None) or (type(name) is cls):
        return name
    elif isinstance(name, str):
        return getattr(cls, name, None)
    elif isinstance(name, int):
        try:
            return cls(name)
        except Exception:
            pass


cdef object _uppercase_id_for_name(cls, name):
    cdef object result

    if (name is None) or (type(name) is cls):
        return name
    elif isinstance(name, str):
        result = getattr(cls, name, None)
        if result is not None:
            return result
        else:
            return getattr(cls, name.upper(), None)
    elif isinstance(name, int):
        try:
            return cls(name)
        except Exception:
            pass


cdef object _titlecase_id_for_name(cls, name):
    cdef object result

    if (name is None) or (type(name) is cls):
        return name
    elif isinstance(name, str):
        result = getattr(cls, name, None)
        if result is not None:
            return result
        else:
            return getattr(cls, name.title(), None)
    elif isinstance(name, int):
        try:
            return cls(name)
        except Exception:
            pass


cdef object option_id_for_name(name):
    cdef Py_ssize_t opt_id_int
    cdef object result1
    cdef object result2
    cdef type cls = _OptionId

    if (name is None) or (type(name) is cls):
        return name

    if isinstance(name, str):
        result1 = getattr(cls, name, None)
        if result1 is not None:
            return result1

    opt_id_int = _EnsureId[TidyOptionId]._do(
        name, tidyOptGetIdForName,
        <Py_ssize_t> TidyUnknownOption, <Py_ssize_t> N_TIDY_OPTIONS,
    )
    if opt_id_int >= 0:
        result2 = PyLong_FromSsize_t(opt_id_int)
        try:
            return cls(result2)
        except Exception:
            pass
        return result2
    else:
        return None


cdef object config_category_for_name(name):
    return _generic_id_for_name(_ConfigCategory, name)


cdef object option_type_for_name(name):
    return _titlecase_id_for_name(_OptionType, name)


cdef object tristate_for_name(name):
    cdef type cls = _TriState
    if name is True:
        return cls.Yes
    elif name is False:
        return cls.No
    else:
        return _titlecase_id_for_name(cls, name)


cdef object use_custom_tags_state_for_name(name):
    return _titlecase_id_for_name(_UseCustomTagsState, name)


cdef object line_endings_for_name(name):
    cdef char *string
    cdef Py_ssize_t length = 0
    cdef type cls = _LineEnding

    if isinstance(name, bytes):
        PyBytes_AsStringAndSize(name, &string, &length)
    elif isinstance(name, unicode):
        string = PyUnicode_AsUTF8AndSize(name, &length)

    if length == 1:
        if string[0] in b'\nnN':
            return cls.LF
        elif string[0] in b'\rrR':
            return cls.CR
    elif length == 2:
        if (string[0] in b'\rrR') and (string[1] in b'\nnN'):
            return cls.CRLF

    return _uppercase_id_for_name(cls, name)


cdef object attr_id_for_name(name):
    cdef object result
    cdef type cls = _AttrId

    if (name is None) or (type(name) is cls):
        return name
    elif isinstance(name, str):
        result = getattr(cls, name, None)
        if result is not None:
            return result
        else:
            name = name.upper()
            if len(name) > 2 and name.startswith('ON'):
                name = 'On' + name[2:]
            return getattr(cls, name.upper(), None)
    elif isinstance(name, int):
        try:
            return cls(name)
        except Exception:
            pass


cdef object encoding_options_for_name(name):
    return _titlecase_id_for_name(_EncodingOptions, name)


cdef object doctype_modes_for_name(name):
    return _titlecase_id_for_name(_DoctypeModes, name)


cdef object tag_id_for_name(name):
    return _uppercase_id_for_name(_TagId, name)


cdef object dup_attr_modes_for_name(name):
    return _generic_id_for_name(_DupAttrModes, name)


cdef object attr_sort_strategy_for_name(name):
    return _titlecase_id_for_name(_AttrSortStrategy, name)


cdef object uppercase_for_name(name):
    cdef type cls = _Uppercase
    if name is True:
        return cls.Yes
    elif name is False:
        return cls.No
    else:
        return _titlecase_id_for_name(cls, name)


cdef object node_type_for_name(name):
    return _generic_id_for_name(_NodeType, name)


cdef object report_level_for_name(name):
    return _generic_id_for_name(_ReportLevel, name)


cdef object parse_outcome_for_name(name):
    return _titlecase_id_for_name(_ParseOutcome, name)


cdef object format_parameter_type_for_name(name):
    return _uppercase_id_for_name(_FormatParameterType, name)


cdef object strings_for_name(name):
    return _generic_id_for_name(_Strings, name)

