Options
=======

.. autofunction:: pytidyhtml5.Option


Getters
-------

.. autoattribute:: pytidyhtml5.Option.id

.. autoattribute:: pytidyhtml5.Option.name

.. autoattribute:: pytidyhtml5.Option.type

.. autoattribute:: pytidyhtml5.Option.is_list

.. autoattribute:: pytidyhtml5.Option.is_readonly

.. autoattribute:: pytidyhtml5.Option.category

.. autoattribute:: pytidyhtml5.Option.default

.. autoattribute:: pytidyhtml5.Option.value


Setters
-------

.. automethod:: pytidyhtml5.Option.set_value

.. automethod:: pytidyhtml5.Option.reset


Iterators
---------

.. automethod:: pytidyhtml5.Option.__iter__

.. automethod:: pytidyhtml5.Option.iter_picklist

.. automethod:: pytidyhtml5.Option.iter_linked_options


Miscellaneous
-------------

.. automethod:: pytidyhtml5.Option.__bool__

.. automethod:: pytidyhtml5.Option.__len__

.. automethod:: pytidyhtml5.Option.__eq__

.. automethod:: pytidyhtml5.Option.__ne__



Getters as methods
------------------

All getters exist as methods, too:

.. autosummary::

    ~pytidyhtml5.Option.get_id
    ~pytidyhtml5.Option.get_name
    ~pytidyhtml5.Option.get_type
    ~pytidyhtml5.Option.get_is_list
    ~pytidyhtml5.Option.get_is_readonly
    ~pytidyhtml5.Option.get_category
    ~pytidyhtml5.Option.get_default
    ~pytidyhtml5.Option.get_value
