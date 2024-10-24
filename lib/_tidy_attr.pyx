@final
@no_gc
@auto_pickle(False)
cdef class Attr:
    '''
    An HTML attribute of a :class:`pytidyhtml5.Node`.
    '''
    cdef TidyAttr tidy_attr

    cdef readonly Node node
    '''
    Related node.
    '''

    def get_node(Attr self):
        '''
        Related node.
        '''
        return self.node

    def __cinit__(Attr self):
        self.tidy_attr = NULL

    def __init__(Attr self, Node node=None):
        self.node = node

    _non_zero_doc = (
        'An Attr is truthy if the attribute exists and the Node did not expire.'
    )

    cdef inline boolean _nonzero(Attr self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_attr is NULL:
            return False
        else:
            return self.node._nonzero()

    def __nonzero__(Attr self):
        return self._nonzero()

    def __repr__(Attr self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_attr
        if addr != 0:
            return f'<Attr @ 0x{addr:x}>'
        else:
            return f'<Attr>'

    def __eq__(Attr self, other):
        '''
        An Attr compares equal if the underlying attributes are the same,
        i.e. same attribute in the same Node in the same Document.
        '''
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_attr is not NULL) and (self.tidy_attr is (<Attr> other).tidy_attr)

    def __ne__(Attr self, other):
        '''
        Simply ``not (self == other)``
        '''
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_attr is NULL) or (self.tidy_attr is not (<Attr> other).tidy_attr)

    def get_next(Attr self):
        '''
        The the next attribute of the Node.

        Returns
        -------
        Attr
            The next attribute. Falsy if there was no further attribute.
        None
            self is falsy
        '''
        cdef Attr result
        cdef TidyAttr tidy_attr = self.tidy_attr

        if tidy_attr is not NULL:
            tidy_attr = tidyAttrNext(tidy_attr)
            result = Attr(self.node)
            result.tidy_attr = tidy_attr
            return result

    cpdef get_name(Attr self):
        '''
        Name of the attribute.

        Returns
        -------
        str
            Name of the attribute
        None
            self is falsy
        '''
        return _unicode_fn(self.tidy_attr, tidyAttrName)

    cpdef get_value(Attr self):
        '''
        Value of the attribute

        Returns
        -------
        str
            Value of the attribute
        None
            self is falsy
        '''
        return _unicode_fn(self.tidy_attr, tidyAttrValue)

    def __len__(Attr self):
        '''
        Length of the attribute iterator.

        Returns
        -------
        int
            ``2 if bool(self) else 0``
        '''
        return 2 if self else 0

    def __iter__(Attr self):
        '''
        Yields name and value

        Yields
        ------
        str
            Name and value
        None
            self is falsy
        '''
        return iter((self.get_name(), self.get_value()))

    def discard(Attr self):
        '''
        Remove the current attribute.

        BEWARE: Any further access to this attribute, e.g. when you queried
        it twice will result in a segmentation fault.

        Returns
        -------
        True
            if successful
        None
            self is falsy, e.g. if it already was discarded.
        '''
        cdef TidyAttr tidy_attr = self.tidy_attr
        cdef Node node = self.node
        cdef TidyNode tidy_node
        cdef TidyDoc tidy_doc
        cdef Document document

        self.tidy_attr = NULL
        self.node = None

        if (tidy_attr is NULL) or (node is None):
            return

        tidy_node = node.tidy_node
        document = node.document

        if (tidy_node is NULL) or (document is None):
            return

        tidy_doc = document.tidy_doc
        if tidy_doc is NULL:
            return

        with nogil:
            tidyAttrDiscard(tidy_doc, tidy_node, tidy_attr)

        return True

    cpdef get_id(Attr self):
        '''
        Numerical ID of the attribute.

        Returns
        -------
        TidyAttrId
            ID of the attribute
        int
            The library reported an unknown value
        None
            self is falsy
        '''
        return _GetEnum[TidyAttr, TidyAttrId]._do(self.tidy_attr, tidyAttrGetId, _AttrId)

    cpdef get_is_event(Attr self):
        '''
        Returns whether the attribute is a JavaScript handler, e.g. onclick.

        Returns
        -------
        bool
            Yes or no
        None
            self is falsy
        '''
        return _bool_fn(self.tidy_attr, tidyAttrIsEvent)

    name = property(get_name)
    value = property(get_value)
    id = property(get_id)
    is_event = property(get_is_event)
