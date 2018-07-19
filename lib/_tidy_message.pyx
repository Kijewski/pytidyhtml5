@final
@no_gc
@auto_pickle(False)
cdef class Message:
    cdef readonly Document document
    cdef TidyMessage tidy_message

    def __cinit__(Message self, Document document):
        self.document = document

    def get_document(Message self):
        return self.document

    cdef inline boolean _nonzero(Message self) nogil:
        if self is None:
            return False
        elif self.tidy_message is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(Message self):
        return self._nonzero()

    cpdef get_format_default(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageFormatDefault)

    cpdef get_format(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageFormat)

    cpdef get_default(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageDefault)

    cpdef get_pos_default(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessagePosDefault)

    cpdef get_pos(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessagePos)

    cpdef get_prefix_default(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessagePrefixDefault)

    cpdef get_prefix(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessagePrefix)

    cpdef get_output_default(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageOutputDefault)

    cpdef get_output(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageOutput)

    cpdef get_message(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessage)

    cpdef get_code(Message self):
        return _GetEnum[TidyMessage, uint]._do(self.tidy_message, tidyGetMessageCode, _Strings)

    cpdef get_key(Message self):
        return _unicode_fn(self.tidy_message, tidyGetMessageKey)

    cpdef get_position(Message self):
        return (
            _int_fn(self.tidy_message, tidyGetMessageLine),
            _int_fn(self.tidy_message, tidyGetMessageColumn)
        )

    cpdef get_is_muted(Message self):
        return _bool_fn(self.tidy_message, tidyGetMessageIsMuted)

    cpdef get_level(Message self):
        return _GetEnum[TidyMessage, TidyReportLevel]._do(self.tidy_message, tidyGetMessageLevel, _ReportLevel)

    def iter_args(Message self):
        return MessageIterArgs(self)

    def iter_values(Message self):
        return MessageIterValues(self)

    format_default = property(get_format_default)
    format = property(get_format)
    default = property(get_default)
    pos_default = property(get_pos_default)
    pos = property(get_pos)
    prefix_default = property(get_prefix_default)
    prefix = property(get_prefix)
    output_default = property(get_output_default)
    output = property(get_output)
    message = property(get_message)
    code = property(get_code)
    key = property(get_key)
    position = property(get_position)
    is_muted = property(get_is_muted)
    level = property(get_level)


@final
@no_gc
@auto_pickle(False)
cdef class MessageArg:
    cdef readonly Message message
    cdef TidyMessageArgument tidy_arg

    def __cinit__(MessageArg self, Message message):
        self.message = message

    cdef inline boolean _nonzero(MessageArg self) nogil:
        if self is None:
            return False
        elif self.tidy_arg is NULL:
            return False
        else:
            return self.message._nonzero()

    def __nonzero__(MessageArg self):
        return self._nonzero()

    cpdef get_type(MessageArg self):
        cdef TidyFormatParameterType typ
        cdef TidyMessage tidy_message
        cdef object result
        cdef Message message = self.message
        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                typ = tidyGetArgType(tidy_message, &self.tidy_arg)
                result = PyLong_FromLong(<long> typ)
                try:
                    result = _FormatParameterType(result)
                except Exception:
                    pass
                return result

    cpdef get_value(MessageArg self):
        cdef Message message = self.message
        cdef TidyMessageArgument tidy_arg = self.tidy_arg
        cdef TidyMessage tidy_message

        if (message is not None) and (tidy_arg is not NULL):
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                return get_message_value(tidy_message, tidy_arg)

    cpdef get_format(MessageArg self):
        cdef Message message = self.message
        if message is not None:
            return _unicode_fn(message.tidy_message, tidyGetArgFormat, &self.tidy_arg)

    type = property(get_type)
    value = property(get_value)
    format = property(get_format)


cdef object get_message_value(TidyMessage tidy_message, TidyMessageArgument tidy_arg):
    cdef ctmbstr text
    cdef TidyFormatParameterType typ = tidyGetArgType(tidy_message, &tidy_arg)
    if typ is tidyFormatType_INT:
        return tidyGetArgValueInt(tidy_message, &tidy_arg)
    if typ is tidyFormatType_UINT:
        return tidyGetArgValueUInt(tidy_message, &tidy_arg)
    if typ is tidyFormatType_STRING:
        text = tidyGetArgValueString(tidy_message, &tidy_arg)
        if text is not NULL:
            return PyUnicode_DecodeUTF8(text, strlen(text), b'replace')
        else:
            return PyUnicode_New(0, 0)
    if typ is tidyFormatType_DOUBLE:
        return tidyGetArgValueDouble(tidy_message, &tidy_arg)
    else:
        return False


@final
@no_gc
@auto_pickle(False)
cdef class MessageIterArgs:
    cdef readonly Message message
    cdef TidyIterator tidy_iterator

    def __cinit__(self, Message message):
        cdef TidyMessage tidy_message
        cdef TidyIterator tidy_iterator

        self.tidy_iterator = NULL

        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                tidy_iterator = tidyGetMessageArguments(tidy_message)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.message = message

    cdef inline boolean _nonzero(self) nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.message._nonzero()

    def __nonzero__(self):
        return self._nonzero()

    def __iter__(self):
        return self

    def __next__(self):
        cdef TidyMessage tidy_message
        cdef TidyMessageArgument tidy_arg
        cdef Message message = self.message
        cdef MessageArg result

        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                while self.tidy_iterator is not NULL:
                    tidy_arg = tidyGetNextMessageArgument(tidy_message, &self.tidy_iterator)
                    if tidy_arg is not NULL:
                        result = MessageArg(message)
                        result.tidy_arg = tidy_arg
                        return result

        self.tidy_iterator = NULL
        self.message = None

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class MessageIterValues:
    cdef readonly Message message
    cdef TidyIterator tidy_iterator

    def __cinit__(self, Message message):
        cdef TidyMessage tidy_message
        cdef TidyIterator tidy_iterator

        self.tidy_iterator = NULL

        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                tidy_iterator = tidyGetMessageArguments(tidy_message)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.message = message

    cdef inline boolean _nonzero(self) nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.message._nonzero()

    def __nonzero__(self):
        return self._nonzero()

    def __iter__(self):
        return self

    def __next__(self):
        cdef TidyMessage tidy_message
        cdef TidyMessageArgument tidy_arg
        cdef Message message = self.message

        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                while self.tidy_iterator is not NULL:
                    tidy_arg = tidyGetNextMessageArgument(tidy_message, &self.tidy_iterator)
                    if tidy_arg is not NULL:
                        return get_message_value(tidy_message, tidy_arg)

        self.tidy_iterator = NULL
        self.message = None

        raise StopIteration
