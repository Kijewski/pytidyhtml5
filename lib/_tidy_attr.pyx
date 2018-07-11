@final
@no_gc
@auto_pickle(False)
cdef class Attr:
    cdef TidyAttr tidy_attr
    cdef readonly Node node

    def __cinit__(self, Node node=None):
        self.tidy_attr = NULL
        self.node = node

    def __nonzero__(Attr self):
        return (self.tidy_attr is not NULL) and bool(self.node)

    def __repr__(Attr self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_attr
        if addr != 0:
            return f'<Attr @ 0x{addr:x}>'
        else:
            return f'<Attr>'

    def __eq__(Attr self, other):
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_attr is not NULL) and (self.tidy_attr is (<Attr> other).tidy_attr)

    def __ne__(Attr self, other):
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_attr is NULL) or (self.tidy_attr is not (<Attr> other).tidy_attr)

    def get_next(Node self):
        cdef Attr result
        cdef TidyAttr tidy_attr = self.tidy_attr

        if tidy_attr is not NULL:
            tidy_attr = tidyAttrNext(tidy_attr)
            if tidy_attr is not NULL:
                result = Attr(self.node)
                result.tidy_attr = tidy_attr
                return result

    cpdef get_name(Attr self):
        return _unicode_fn(self.tidy_attr, tidyAttrName)

    cpdef get_value(Attr self):
        return _unicode_fn(self.tidy_attr, tidyAttrValue)

    def __len__(self):
        return 2 if self else 0

    def __iter__(self):
        return iter((self.get_name(), self.get_value()))

    def discard(Attr self):
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
        return _GetEnum[TidyAttr, TidyAttrId]._do(self.tidy_attr, tidyAttrGetId, _AttrId)

    cpdef get_is_event(Attr self):
        return _bool_fn(self.tidy_attr, tidyAttrIsEvent)

    name = property(get_name)
    value = property(get_value)
    id = property(get_id)
    is_event = property(get_is_event)
