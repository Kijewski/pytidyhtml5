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

    pytidyhtml5.Node.parent
    pytidyhtml5.Node.child
    pytidyhtml5.Node.next
    pytidyhtml5.Node.prev
    pytidyhtml5.Node.attr_first
    pytidyhtml5.Node.name
    pytidyhtml5.Node.position
    pytidyhtml5.Node.is_text
    pytidyhtml5.Node.id
    pytidyhtml5.Node.type
