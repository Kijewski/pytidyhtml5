@final
@no_gc
@auto_pickle(False)
cdef class Message:
    '''
    Instances that get passed to :attr:`pytidyhtml5.Document.message_callback`.
    '''

    cdef readonly Document document
    '''
    The assigned document.
    '''

    cdef TidyMessage tidy_message

    def __init__(Message self, Document document):
        self.document = document

    def get_document(Message self):
        '''
        The assigned document.

        Returns
        -------
        :class:`pytidyhtml5.Document`
            The document
        None
            The message expired, i.e. the callback was already left.
        '''
        return self.document

    cdef inline boolean _nonzero(Message self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_message is NULL:
            return False
        else:
            return self.document._nonzero()

    _non_zero_doc = (
        'A Message is only valid in its callback. After the callback returns, '
        'no values can be queried anymore.'
    )

    def __nonzero__(Message self):
        return self._nonzero()

    cpdef get_format_default(Message self):
        '''
        Get the default format string, which is the format string for the message
        in Tidy's default localization (en_us).

        Returns
        -------
        str
            Default format string
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageFormatDefault)

    cpdef get_format(Message self):
        '''
        Get the localized format string. If a localized version of the format string
        doesn't exist, then the default version will be returned.

        Returns
        -------
        str
            Default localized string
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageFormat)

    cpdef get_default(Message self):
        '''
        Get the message with the format string already completed, in Tidy's default localization.

        Returns
        -------
        str
            Default message string.
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageDefault)

    cpdef get_message(Message self):
        '''
         Get the message with the format string already completed, in Tidy's current localization.

        Returns
        -------
        str
            Default message string.
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessage)

    cpdef get_pos_default(Message self):
        '''
        Get the position part part of the message in the default language.

        Returns
        -------
        str
            position part
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessagePosDefault)

    cpdef get_pos(Message self):
        '''
        Get the position part part of the message in the current language.

        Returns
        -------
        str
            position part
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessagePos)

    cpdef get_prefix_default(Message self):
        '''
        Get the prefix part of a message in the default localization.

        Returns
        -------
        str
            prefix part
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessagePrefixDefault)

    cpdef get_prefix(Message self):
        '''
        Get the prefix part of a message in the current language.

        Returns
        -------
        str
            prefix part
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessagePrefix)

    cpdef get_output_default(Message self):
        '''
        Get the complete message as Tidy would emit it in the default language.

        Returns
        -------
        str
            complete message
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageOutputDefault)

    cpdef get_output(Message self):
        '''
        Get the complete message as Tidy would emit it in the current localization.

        Returns
        -------
        str
            complete message
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageOutput)

    cpdef get_code(Message self):
        '''
        Get the message code.

        This method is not useful. :-)

        Returns
        -------
        int
            Message code
        None
            The message expired, i.e. the callback was already left.
        '''
        return _GetEnum[TidyMessage, uint]._do(self.tidy_message, tidyGetMessageCode, _Strings)

    cpdef get_key(Message self):
        '''
        Get the message key string.

        Returns
        -------
        str
            Message key
        None
            The message expired, i.e. the callback was already left.
        '''
        return _unicode_fn(self.tidy_message, tidyGetMessageKey)

    cpdef get_position(Message self):
        '''
        Get the line number and column the message applies to.

        Returns
        -------
        tuple[int, int]
            Line number and column
        None
            The message expired, i.e. the callback was already left.
        '''
        if self._nonzero():
            return (
                _int_fn(self.tidy_message, tidyGetMessageLine),
                _int_fn(self.tidy_message, tidyGetMessageColumn)
            )

    cpdef get_is_muted(Message self):
        '''
        Get the muted status of the message, that is, whether or not the
        current configuration indicated that this message should be muted.

        Returns
        -------
        bool
            True if muted
        None
            The message expired, i.e. the callback was already left.
        '''
        return _bool_fn(self.tidy_message, tidyGetMessageIsMuted)

    cpdef get_level(Message self):
        '''
        Get the TidyReportLevel of the message.

        Returns
        -------
        :class:`pytidyhtml5.ReportLevel`
            Report level
        None
            The message expired, i.e. the callback was already left.
        '''
        return _GetEnum[TidyMessage, TidyReportLevel]._do(self.tidy_message, tidyGetMessageLevel, _ReportLevel)

    def iter_args(Message self):
        '''
        An iterator yielding :class:`pytidyhtml5.MessageArg` objects.

        Yields
        ------
        :class:`pytidyhtml5.MessageArg`
            Arguments for the current message.
        '''
        return MessageIterArgs(self)

    def iter_values(Message self):
        '''
        An iterator yielding argument values.

        Funtionally equivalent to:

        .. code-block:: python

            for arg in self.iter_args():
                yield arg.value

        Yields
        ------
        int|str|float
            Argument value
        '''
        return MessageIterValues(self)

    default = property(get_default)
    message = property(get_message)
    format_default = property(get_format_default)
    format = property(get_format)
    pos_default = property(get_pos_default)
    pos = property(get_pos)
    prefix_default = property(get_prefix_default)
    prefix = property(get_prefix)
    output_default = property(get_output_default)
    output = property(get_output)
    code = property(get_code)
    key = property(get_key)
    position = property(get_position)
    is_muted = property(get_is_muted)
    level = property(get_level)


@final
@no_gc
@auto_pickle(False)
cdef class MessageArg:
    '''
    A :class:`pytidyhtml5.Message` format value.
    '''

    '''
    Related message.
    '''
    cdef readonly Message message

    cdef TidyMessageArgument tidy_arg

    def get_message(Message self):
        '''
        Related message.
        '''
        return self.message

    def __cinit__(MessageArg self):
        self.tidy_arg = NULL

    def __init__(MessageArg self, Message message):
        self.message = message

    cdef inline boolean _nonzero(MessageArg self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_arg is NULL:
            return False
        else:
            return self.message._nonzero()

    _non_zero_doc = (
        'A MessageArg is truthy iff its Message is truthy.'
    )

    def __nonzero__(MessageArg self):
        return self._nonzero()

    cpdef get_type(MessageArg self):
        '''
        Type of the argument's value.

        Returns
        -------
        :class:`pytidyhtml.FormatParameterType`
            The value type.
        None
            The message expired.
        '''
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

    cpdef get_cls(MessageArg self):
        '''
        Python :class:`type` of the argument's value.

        Returns
        -------
        type
            The value type.
        None
            The message expired.
        '''
        cdef TidyFormatParameterType typ
        cdef TidyMessage tidy_message
        cdef object result
        cdef Message message = self.message
        if message is not None:
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                typ = tidyGetArgType(tidy_message, &self.tidy_arg)
                if typ in (tidyFormatType_INT, tidyFormatType_UINT):
                    return int
                elif typ is tidyFormatType_STRING:
                    return str
                elif typ is tidyFormatType_DOUBLE:
                    return float

    cpdef get_value(MessageArg self):
        '''
        Value of the argument.

        Returns
        -------
        int|str|float
            The value.
        None
            The message expired.
        '''
        cdef Message message = self.message
        cdef TidyMessageArgument tidy_arg = self.tidy_arg
        cdef TidyMessage tidy_message

        if (message is not None) and (tidy_arg is not NULL):
            tidy_message = message.tidy_message
            if tidy_message is not NULL:
                return get_message_value(tidy_message, tidy_arg)

    cpdef get_format(MessageArg self):
        '''
        C format string to format the value.
        '''
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

    cdef inline boolean _nonzero(self) noexcept nogil:
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

    cdef inline boolean _nonzero(self) noexcept nogil:
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
