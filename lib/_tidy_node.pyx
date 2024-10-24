@final
@no_gc
@auto_pickle(False)
cdef class NodeIterChildren:
    cdef readonly Node node

    def __cinit__(NodeIterChildren self, Node parent):
        if parent is not None:
            self.node = parent.get_child()

    cdef inline boolean _nonzero(NodeIterChildren self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.node._nonzero()

    def __nonzero__(NodeIterChildren self):
        return self._nonzero()

    def __iter__(NodeIterChildren self):
        return self

    def __next__(NodeIterChildren self):
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

    def __cinit__(NodeIterAttributes self, Node parent):
        if parent is not None:
            self.attr = parent.get_attr_first()

    cdef inline boolean _nonzero(NodeIterAttributes self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.attr._nonzero()

    def __nonzero__(NodeIterAttributeIds self):
        return self._nonzero()

    def __iter__(NodeIterAttributes self):
        return self

    def __next__(NodeIterAttributes self):
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

    def __cinit__(NodeIterAttributeIds self, Node parent):
        if parent is not None:
            self.attr = parent.get_attr_first()

    cdef inline boolean _nonzero(NodeIterAttributeIds self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.attr._nonzero()

    def __nonzero__(NodeIterAttributeIds self):
        return self._nonzero()

    def __iter__(NodeIterAttributeIds self):
        return self

    def __next__(NodeIterAttributeIds self):
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

    def __cinit__(NodeAttrProxy self, Node node):
        self.node = node

    cdef inline boolean _nonzero(NodeAttrProxy self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.node._nonzero()

    def __nonzero__(NodeAttrProxy self):
        return self._nonzero()

    def __iter__(NodeAttrProxy self):
        return NodeIterAttributeIds(self.node)

    def __getitem__(NodeAttrProxy self, id):
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

    def __delitem__(NodeAttrProxy self, id):
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
    '''
    A node in the deserialized document.

    This includes text nodes, processing instructions and more,
    cf. :class:`~pytidyhtml5.NodeType`.
    '''

    cdef TidyNode tidy_node
    cdef readonly Document document

    def __cinit__(Node self):
        self.tidy_node = NULL

    def __init__(Node self, Document document=None):
        self.document = document

    _non_zero_doc = (
        'A Node is truthy if it has an assigned TidyNode (i.e. if it was '
        'created by some :class:`~pytidyhtml5.Document` method), '
        'and the document has was not been released in the meantime.'
    )

    cdef inline boolean _nonzero(Node self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_node is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(Node self):
        return self._nonzero()

    def __repr__(Node self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_node
        if addr != 0:
            return f'<Node @ 0x{addr:x}>'
        else:
            return f'<Node>'

    def __eq__(Node self, other):
        '''
        Compares the underlying node.

        If you get the same node twice from a document, you will will have
        two distinct :class:`pytidyhtml5.Node` instances that compare
        equal.
        '''
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_node is not NULL) and (self.tidy_node is (<Node> other).tidy_node)

    def __ne__(Node self, other):
        '''
        Simply ``not (self == other)``
        '''
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_node is NULL) or (self.tidy_node is not (<Node> other).tidy_node)

    cdef object __get_node(Node self, TidyNode fn(TidyNode) noexcept nogil):
        cdef Node result
        cdef TidyNode tidy_node = self.tidy_node

        if tidy_node is not NULL:
            tidy_node = fn(tidy_node)
            if tidy_node is not NULL:
                result = Node(self.document)
                result.tidy_node = tidy_node
                return result

    cpdef get_parent(Node self):
        '''
        Returns the parent node.

        Returns
        -------
        :class:`pytidyhtml5.Node`
            The parent node.
        None:
            If ``self.type == NodeType.root`` or ``not bool(self)``.
        '''
        return self.__get_node(tidyGetParent)

    cpdef get_child(Node self):
        '''
        Returns the first child node.

        Returns
        -------
        :class:`pytidyhtml5.Node`
            The first child node.
        None:
            If ``not bool(self)`` or the if ``self`` has no children.
        '''
        return self.__get_node(tidyGetChild)

    cpdef get_next(Node self):
        '''
        Returns the next sibling node.

        Returns
        -------
        :class:`pytidyhtml5.Node`
            The next child sibling node.
        None:
            If ``not bool(self)`` or there are no further siblings.
        '''
        return self.__get_node(tidyGetNext)

    cpdef get_prev(Node self):
        '''
        Returns the previous sibling node.

        Returns
        -------
        :class:`pytidyhtml5.Node`
            The previous child sibling node.
        None:
            If ``not bool(self)`` or there are no prior siblings.
        '''
        return self.__get_node(tidyGetPrev)

    def discard(Node self):
        '''
        Removes the current not from the document.

        If the have a second reference to the current node, then don't use it anymore.
        In the best case the program will only crash.

        Returns
        -------
        :class:`pytidyhtml5.Node`
            The next sibling. The result may be falsy, if the discarded node
            was the last node.
        None:
            If ``not bool(self)``.
        '''
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

        result = Node(self.document)
        result.tidy_node = tidy_node
        return result

    cpdef get_attr_first(Node self):
        '''
        Returns the first attribute.

        Returns
        -------
        :class:`pytidyhtml5.Attr`
            The first attribute.
        None:
            If ``not bool(self)`` or the if ``self`` has no attributes.
        '''
        cdef Attr result
        cdef TidyNode tidy_node = self.tidy_node
        cdef TidyAttr tidy_attr

        if tidy_node is not NULL:
            tidy_attr = tidyAttrFirst(tidy_node)
            if tidy_attr is not NULL:
                result = Attr(self)
                result.tidy_attr = tidy_attr
                return result

    cpdef get_attr_by_id(Node self, name):
        '''
        Returns an attribute by its Id.

        Arguments
        ---------
        :class:`pytidyhtml5.AttrId`|int|str
            The argument to retrieve.

        Returns
        -------
        :class:`pytidyhtml5.Attr`
            The matcjing attribute.
        None:
            If ``not bool(self)`` or there was not such attribute.
        '''
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
        '''
        Yield the children of the current node.

        Essentially the same as

        .. code-block:: python

            node = self.get_child()
            while node:
                yield node
                node = node.get_next()

        Expect undefined behavior if you alter the tree during an iteration.

        Yields
        ------
        :class:`pytidyhtml5.Node`
            Children of the current node.
        '''
        return NodeIterChildren(self)

    def iter_attrs(Node self):
        '''
        Yield the attributes of the current node.

        Essentially the same as

        .. code-block:: python

            attr = self.get_attr_first()
            while attr:
                yield attr
                attr = attr.get_next()

        Expect undefined behavior if you alter the tree during an iteration.

        Yields
        ------
        :class:`pytidyhtml5.Attr`
            Attributes of the current node.
        '''
        return NodeIterAttributes(self)

    cpdef get_name(Node self):
        '''
        Returns the tag name of the current node.

        Returns
        -------
        str
            Tag name of the current node.
        None
            If the node was falsy or the node does not have a name.
        '''
        return _unicode_fn(self.tidy_node, tidyNodeGetName)

    cpdef get_position(Node self):
        '''
        Returns a tuple of the position in the input stream.

        Returns
        -------
        tuple
            line and column
        None
            If the node was falsy.
        '''
        cdef uint line, column
        cdef TidyNode tidy_node = self.tidy_node
        if tidy_node is not NULL:
            line = tidyNodeLine(tidy_node)
            column = tidyNodeColumn(tidy_node)
            return line, column

    cpdef get_is_text(Node self):
        '''
        Returns whether the current node is a text node.

        Same as ``self.type is NoteType.Text``.

        Returns
        -------
        bool
            Yes or no.
        None
            If the node was falsy.
        '''
        return _bool_fn(self.tidy_node, tidyNodeIsText)

    cpdef get_tag_id(Node self):
        '''
        Returns the tag of the current node numerically.

        Returns
        -------
        :class:`pytidyhtml5.TagId`
            Id of the current tag.
        int
            The result was not understood. Is the loaded tidy.so newer than this wrapper?
        None
            ``not bool(self)``
        '''
        return _GetEnum[TidyNode, TidyTagId]._do(self.tidy_node, tidyNodeGetId, _TagId)

    cpdef get_node_type(Node self):
        '''
        Returns the type of the current node.

        Returns
        -------
        :class:`pytidyhtml5.NodeType`
            Id of the current node type.
        int
            The result was not understood. Is the loaded tidy.so newer than this wrapper?
        None
            ``not bool(self)``
        '''
        return _GetEnum[TidyNode, TidyNodeType]._do(self.tidy_node, tidyNodeGetType, _NodeType)

    @property
    def attr(Node self):
        '''
        A proxy for easier access of the node's attributes.

        E.g.

        .. code:: python

            self.attr['id']                 # retrieve attribute value
            self.attr['id'] = 'some_value'  # set attribute value
            del self.attr['id']             # discard attribute

            set(self.attr) == { AttrId.ALT, ... }  # Iterate over set ids
        '''
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
