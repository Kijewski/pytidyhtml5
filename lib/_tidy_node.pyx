@final
@no_gc
@auto_pickle(False)
cdef class NodeIterChildren:
    cdef readonly Node node

    def __cinit__(self, Node parent):
        if parent is not None:
            self.node = parent.get_child()

    def __nonzero__(self):
        return bool(self.node)

    def __iter__(self):
        return self

    def __next__(self):
        cdef Node result = self.node
        if result is not None:
            self.node = result.get_next()
            return result
        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class NodeIterAttributes:
    cdef readonly Attr attr

    def __cinit__(self, Node parent):
        if parent is not None:
            self.attr = parent.get_attr_first()

    def __nonzero__(self):
        return bool(self.attr)

    def __iter__(self):
        return self

    def __next__(self):
        cdef Attr result = self.attr
        if result is not None:
            self.attr = result.get_next()
            return result
        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class NodeIterAttributeIds:
    cdef readonly Attr attr

    def __cinit__(self, Node parent):
        if parent is not None:
            self.attr = parent.get_attr_first()

    def __nonzero__(self):
        return bool(self.attr)

    def __iter__(self):
        return self

    def __next__(self):
        cdef object name
        cdef Attr result

        while True:
            attr = self.attr
            if attr is None:
                raise StopIteration

            self.attr = attr.get_next()

            name = attr.get_id()
            if name is not None:
                return name


@final
@no_gc
@auto_pickle(False)
cdef class NodeAttrProxy:
    cdef readonly Node node

    def __cinit__(self, Node node):
        self.node = node

    def __nonzero__(self):
        return bool(self.node)

    def __iter__(self):
        return NodeIterAttributeIds(self.node)

    def __getitem__(self, id):
        cdef Node node = self.node
        cdef Attr attr

        if not node:
            raise KeyError('Node is dead')

        try:
            attr = node.get_attr_by_id(id)
        except Exception as ex:
            raise KeyError from ex

        if attr is None:
            raise KeyError

        return attr.get_value()

    def __delitem__(self, id):
        cdef Node node = self.node
        cdef Attr attr

        if not node:
            raise KeyError('Node is dead')

        try:
            attr = node.get_attr_by_id(id)
        except Exception as ex:
            raise KeyError from ex

        if (attr is None) or (attr.discard() is not True):
            raise KeyError


@final
@no_gc
@auto_pickle(False)
cdef class Node:
    cdef TidyNode tidy_node
    cdef readonly Document document

    def __cinit__(self, Document document=None):
        self.tidy_node = NULL
        self.document = document

    def __nonzero__(Node self):
        return (self.tidy_node is not NULL) and bool(self.document)

    def __repr__(Node self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_node
        if addr != 0:
            return f'<Node @ 0x{addr:x}>'
        else:
            return f'<Node>'

    def __eq__(Node self, other):
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_node is not NULL) and (self.tidy_node is (<Node> other).tidy_node)

    def __ne__(Node self, other):
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_node is NULL) or (self.tidy_node is not (<Node> other).tidy_node)

    cdef object __get_node(Node self, TidyNode fn(TidyNode) nogil):
        cdef Node result
        cdef TidyNode tidy_node = self.tidy_node

        if tidy_node is not NULL:
            tidy_node = fn(tidy_node)
            if tidy_node is not NULL:
                result = Node(self.document)
                result.tidy_node = tidy_node
                return result

    cpdef get_parent(Node self):
        return self.__get_node(tidyGetParent)

    cpdef get_child(Node self):
        return self.__get_node(tidyGetChild)

    cpdef get_next(Node self):
        return self.__get_node(tidyGetNext)

    cpdef get_prev(Node self):
        return self.__get_node(tidyGetPrev)

    def discard(Node self):
        cdef Node result
        cdef TidyDoc tidy_doc
        cdef TidyNode tidy_node
        cdef Document document = self.document

        if document is None:
            return

        tidy_doc = document.tidy_doc
        tidy_node = self.tidy_node
        self.document = None
        self.tidy_node = NULL

        if (tidy_doc is NULL) or (tidy_node is NULL):
            return

        with nogil:
            tidy_node = tidyDiscardElement(tidy_doc, self.tidy_node)

        if tidy_node is not NULL:
            result = Node(self.document)
            result.tidy_node = tidy_node
            return result

    cpdef get_attr_first(Node self):
        cdef Attr result
        cdef TidyNode tidy_node = self.tidy_node
        cdef TidyAttr tidy_attr

        if tidy_node is not NULL:
            tidy_attr = tidyAttrFirst(tidy_node)
            if tidy_node is not NULL:
                result = Attr(self)
                result.tidy_attr = tidy_attr
                return result

    cpdef get_attr_by_id(Node self, name):
        cdef Attr result
        cdef TidyAttr tidy_attr
        cdef object attr_id = attr_id_for_name(name)
        cdef TidyNode tidy_node = self.tidy_node

        if (tidy_node is not NULL) and (attr_id is not None):
            tidy_attr = tidyAttrGetById(tidy_node, <TidyAttrId> PyLong_AsLong(attr_id))
            if tidy_attr is not NULL:
                result = Attr(self)
                result.tidy_attr = tidy_attr
                return result

    def iter_children(Node self):
        return NodeIterChildren(self)

    def iter_attrs(Node self):
        return NodeIterAttributes(self)

    cpdef get_name(Node self):
        return _unicode_fn(self.tidy_node, tidyNodeGetName)

    cpdef get_position(Node self):
        cdef uint line, column
        cdef TidyNode tidy_node = self.tidy_node
        if tidy_node is not NULL:
            line = tidyNodeLine(tidy_node)
            column = tidyNodeColumn(tidy_node)
            return line, column

    cpdef get_is_text(Node self):
        return _bool_fn(self.tidy_node, tidyNodeIsText)

    cpdef get_tag_id(Node self):
        return _GetEnum[TidyNode, TidyTagId]._do(self.tidy_node, tidyNodeGetId, _TagId)

    cpdef get_node_type(Node self):
        return _GetEnum[TidyNode, TidyNodeType]._do(self.tidy_node, tidyNodeGetType, _NodeType)

    @property
    def attr(Node self):
        return NodeAttrProxy(self)

    parent = property(get_parent)
    child = property(get_child)
    next = property(get_next)
    prev = property(get_prev)
    attr_first = property(get_attr_first)
    name = property(get_name)
    position = property(get_position)
    is_text = property(get_is_text)
    id = property(get_tag_id)
    type = property(get_node_type)
