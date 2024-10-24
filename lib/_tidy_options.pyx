@final
@no_gc
@auto_pickle(False)
cdef class OptionPicklist:
    cdef readonly Option option
    cdef TidyIterator tidy_iterator

    def __cinit__(OptionPicklist self, Option option):
        cdef TidyOption tidy_option
        cdef TidyIterator tidy_iterator

        self.tidy_iterator = NULL

        if option is not None:
            tidy_option = option.tidy_option
            if tidy_option is not NULL:
                tidy_iterator = tidyOptGetPickList(tidy_option)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.option = option

    cdef inline boolean _nonzero(OptionPicklist self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.option._nonzero()

    def __nonzero__(OptionPicklist self):
        return self._nonzero()

    def __iter__(OptionPicklist self):
        return self

    def __next__(OptionPicklist self):
        cdef TidyOption tidy_option
        cdef ctmbstr text
        cdef size_t length
        cdef Option option = self.option

        if option is not None:
            tidy_option = option.tidy_option
            if tidy_option is not NULL:
                while self.tidy_iterator is not NULL:
                    text = tidyOptGetNextPick(tidy_option, &self.tidy_iterator)
                    if text is not None:
                        length = strlen(text)
                        return PyUnicode_DecodeUTF8(text, length, b'replace')

        self.tidy_iterator = NULL
        self.option = None

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class OptionIterLinkedOptions:
    cdef readonly Document document
    cdef TidyIterator tidy_iterator

    def __cinit__(OptionIterLinkedOptions self, Option option):
        cdef Document document
        cdef TidyOption tidy_option
        cdef TidyDoc tidy_doc
        cdef TidyIterator tidy_iterator

        self.tidy_iterator = NULL

        if option is not None:
            tidy_option = option.tidy_option
            document = option.document
            if (tidy_option is not NULL) and (document is not None):
                tidy_doc = document.tidy_doc
                if tidy_doc is not NULL:
                    tidy_iterator = tidyOptGetDocLinksList(tidy_doc, tidy_option)
                    if tidy_iterator is not NULL:
                        self.tidy_iterator = tidy_iterator
                        self.document = document

    cdef inline boolean _nonzero(OptionIterLinkedOptions self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(OptionIterLinkedOptions self):
        return self._nonzero()

    def __iter__(OptionIterLinkedOptions self):
        return self

    def __next__(OptionIterLinkedOptions self):
        cdef TidyDoc tidy_doc
        cdef TidyOption tidy_option
        cdef Option result
        cdef Document document = self.document

        if document is not None:
            tidy_doc = self.document.tidy_doc
            if tidy_doc is not NULL:
                while self.tidy_iterator is not NULL:
                    tidy_option = tidyOptGetNextDocLinks(tidy_doc, &self.tidy_iterator)
                    if tidy_option is not NULL:
                        result = Option(document)
                        result.tidy_option = tidy_option
                        return result

        self.tidy_iterator = NULL
        self.document = None

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class Option:
    '''
    An option that effects how a document will be serialized or deserialized.
    '''

    cdef TidyOption tidy_option
    cdef readonly Document document

    def __cinit__(Option self):
        self.tidy_option = NULL

    def __init__(Option self, Document document=None):
        self.document = document

    _non_zero_doc = (
        'An Option is truthy if it has an assigned TidyOption (i.e. if it was '
        'created by some :class:`~pytidyhtml5.Document` method), '
        'and the document has was not been released in the meantime.'
    )

    cdef inline boolean _nonzero(Option self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_option is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(Option self):
        return self._nonzero()

    def __repr__(Option self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_option
        if addr != 0:
            return f'<Option @ 0x{addr:x}>'
        else:
            return f'<Option>'

    def __eq__(Option self, other):
        '''
        Compares the underlying pointer.

        If you get the same option twice from a document, you will will have
        two distinct :class:`~pytidyhtml5.Option` instances that compare
        equal.
        '''
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_option is not NULL) and (self.tidy_option is (<Option> other).tidy_option)

    def __ne__(Option self, other):
        '''
        Simply ``not (self == other)``
        '''
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_option is NULL) or (self.tidy_option is not (<Option> other).tidy_option)

    cpdef get_id(Option self):
        '''
        Returns the unique identifier for this option

        Returns
        -------
        :class:`pytidyhtml5.OptionId`
            The unique identifier for this option.
        int
            The library returned an unknown value.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _GetEnum[TidyOption, TidyOptionId]._do(self.tidy_option, tidyOptGetId, _OptionId)

    cpdef get_name(Option self):
        '''
        Returns the name of the option.

        Returns
        -------
        str
            The name of the option.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _unicode_fn(self.tidy_option, tidyOptGetName)

    cpdef get_type(Option self):
        '''
        Returns the value type of the option.

        Returns
        -------
        :class:`pytidyhtml5.OptionType`
            The value type of the option.
        int
            The library returned an unknown value.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _GetEnum[TidyOption, TidyOptionType]._do(self.tidy_option, tidyOptGetType, _OptionType)

    cpdef get_is_list(Option self):
        '''
        Returns whether the options has a picklist of values to chose from.

        See also: :func:`~Option.iter_picklist()`.

        Returns
        -------
        bool
            Yes or no
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _bool_fn(self.tidy_option, tidyOptionIsList)

    cpdef get_is_readonly(Option self):
        '''
        Returns whether the options is read-only.

        Returns
        -------
        bool
            Yes or no
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _bool_fn(self.tidy_option, tidyOptIsReadOnly)

    cpdef get_category(Option self):
        '''
        Returns the category of the option.

        Returns
        -------
        :class:`pytidyhtml5.ConfigCategory`
            The category of the option.
        int
            The library returned an unknown value.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return _GetEnum[TidyOption, TidyConfigCategory]._do(self.tidy_option, tidyOptGetCategory, _ConfigCategory)

    cpdef get_default(Option self):
        '''
        Returns the default value of the option.

        See also: :func:`~Option.reset()`.

        Returns
        -------
        str|int|bool
            The default value of the option.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        cdef TidyOption tidy_option = self.tidy_option
        cdef TidyOptionType option_type
        if tidy_option is not NULL:
            option_type = tidyOptGetType(tidy_option)
            if option_type is TidyString:
                return _unicode_fn(tidy_option, tidyOptGetDefault)
            elif option_type is TidyInteger:
                return tidyOptGetDefaultInt(tidy_option)
            elif option_type is TidyBoolean:
                return _bool_fn(tidy_option, tidyOptGetDefaultBool)

    def iter_picklist(Option self):
        '''
        Yields possible values for the option if the option is a picklick:
        :data:`~pytidyhtml5.Option.is_picklist`.

        Yields
        ------
        str
            A possible value.  Warning: options that want an integral value
            return a string, too. The string contains a description and cannot
            be used verbatim in :func:`pytidyhtml5.Option.set_value`.
        '''
        return OptionPicklist(self)

    cpdef get_value(Option self):
        '''
        Return the current value of the option.

        Returns
        -------
        str|int|bool
            The current value of the option.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        cdef TidyOptionId opt_id
        cdef TidyOptionType option_type
        cdef TidyOption tidy_option = self.tidy_option
        cdef Document document = self.document
        if (document is not None) and (self.tidy_option is not NULL):
            opt_id = tidyOptGetId(tidy_option)
            if TidyUnknownOption < opt_id < N_TIDY_OPTIONS:
                option_type = tidyOptGetType(tidy_option)
                if option_type is TidyString:
                    return _unicode_fn[TidyDoc, TidyOptionId](document.tidy_doc, tidyOptGetValue, opt_id)
                elif option_type is TidyInteger:
                    return _ulong_fn[TidyDoc, TidyOptionId](document.tidy_doc, tidyOptGetInt, opt_id)
                elif option_type is TidyBoolean:
                    return _bool_fn[TidyDoc, TidyOptionId](document.tidy_doc, tidyOptGetBool, opt_id)

    def __len__(self):
        '''
        Returns if :func:`~pytidyhtml5.Option.__iter__` will be useful.

        Returns
        -------
        int
            2 if the option is good, otherwise 0.
        '''
        return 2 if self else 0

    def __iter__(self):
        '''
        A tuple of :func:`pytidyhtml5.Option.get_name` and :func:`pytidyhtml5.Option.get_value`.

        This function can be useful for debugging if want to see all options at once:
        ``dict(document.iter_options())``.

        Returns
        -------
        tuple[str, str|int|bool]
            The name and value of the option.
        tuple[None, None]
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return iter((self.get_name(), self.get_value()))

    cpdef set_value(Option self, value):
        '''
        Set the value of the option.

        Parameters
        ----------
        value : str|bytes|int|bool|None
            The new value. None resets the option to its default value.

        Returns
        -------
        bool
            True if the value was set.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        cdef TidyOptionId opt_id
        cdef TidyOptionType option_type
        cdef TidyOption tidy_option = self.tidy_option
        cdef Document document = self.document
        cdef TidyDoc tidy_doc

        if (tidy_option is NULL) or (document is None):
            return

        tidy_doc = document.tidy_doc
        if tidy_doc is NULL:
            return

        opt_id = tidyOptGetId(tidy_option)
        if not (TidyUnknownOption < opt_id < N_TIDY_OPTIONS):
            return

        if value is None:
            return tidyOptResetToDefault(tidy_doc, opt_id) is not no

        option_type = tidyOptGetType(tidy_option)
        if option_type is TidyString:
            return document._set_option_str_object(opt_id, value)
        elif option_type is TidyInteger:
            return document._set_option_ulong(opt_id, <ulong> value)
        elif option_type is TidyBoolean:
            return document._set_option_bool(opt_id, <boolean> value)

    cpdef reset(Option self):
        '''
        Reset the option to its default value.

        Returns
        -------
        bool
            True if the value was reset.
        None
            The option was not good anymore, see :func:`~pytidyhtml5.Option.__bool__`.
        '''
        return self.set_value(None)

    def iter_linked_options(Option self):
        '''
        Yields related options.

        This function is mostly meant for debugging purposes.

        Yields
        ------
        :class:`~pytidyhtml5.Option`
            A related option.
        '''
        return OptionIterLinkedOptions(self)

    id = property(get_id)
    name = property(get_name)
    type = property(get_type)
    is_list = property(get_is_list)
    is_readonly = property(get_is_readonly)
    category = property(get_category)
    default = property(get_default)
    value = property(get_value, set_value, None, get_value.__doc__)
