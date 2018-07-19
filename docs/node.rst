Nodes
=====

.. autofunction:: pytidyhtml5.Node


Getters
-------

.. autoattribute:: pytidyhtml5.Node.parent

.. autoattribute:: pytidyhtml5.Node.child

.. autoattribute:: pytidyhtml5.Node.next

.. autoattribute:: pytidyhtml5.Node.prev

.. autoattribute:: pytidyhtml5.Node.attr_first

.. autoattribute:: pytidyhtml5.Node.name

.. autoattribute:: pytidyhtml5.Node.position

.. autoattribute:: pytidyhtml5.Node.is_text

.. autoattribute:: pytidyhtml5.Node.id

.. autoattribute:: pytidyhtml5.Node.type


Setters
-------

.. automethod:: pytidyhtml5.Node.discard


Iterators
---------

.. automethod:: pytidyhtml5.Node.iter_attrs

.. automethod:: pytidyhtml5.Node.iter_children

.. autoattribute:: pytidyhtml5.Node.attr

.. autoattribute:: pytidyhtml5.Node.attr


Miscellaneous
-------------

.. automethod:: pytidyhtml5.Node.__bool__

.. automethod:: pytidyhtml5.Node.__eq__

.. automethod:: pytidyhtml5.Node.__ne__



Getters as methods
------------------

All getters exist as methods, too:

.. autosummary::

    pytidyhtml5.Node.get_parent
    pytidyhtml5.Node.get_child
    pytidyhtml5.Node.get_next
    pytidyhtml5.Node.get_prev
    pytidyhtml5.Node.get_attr_first
    pytidyhtml5.Node.get_name
    pytidyhtml5.Node.get_position
    pytidyhtml5.Node.get_is_text
    pytidyhtml5.Node.get_tag_id
    pytidyhtml5.Node.get_node_type
