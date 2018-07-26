import _pytidyhtml5

from _pytidyhtml5 import *
from ._doc import BUILDING_DOC


__all__ = _pytidyhtml5.__all__
__version__ = _pytidyhtml5.__version__


if BUILDING_DOC:
    from enum import IntEnum

    def _omit_signature(doc):
        if doc:
            return '\n\n'.join(doc.split('\n\n', 1)[1:]).strip()
    
    for name in __all__:
        obj = getattr(_pytidyhtml5, name)
        if isinstance(obj, type):
            if issubclass(obj, IntEnum):
                src = [f'class {name}(IntEnum):']
                src.extend(
                    f'    {__elem.name} = {int(__elem)}'
                    for __elem in obj
                )
                src.extend((
                    '    __slots__ = ()',
                    '    __name__ = __qualname__ = obj.__name__',
                    '    __doc__ = obj.__doc__',
                ))
                eval(compile('\n'.join(src), __file__, 'exec'))
            else:
                src = [f'class {name}:']
                src.extend(
                    f'    {__name} = obj.{__name}'
                    for __name in vars(obj)
                    if __name not in ('__new__', '__pyx_vtable__')
                )
                src.extend(
                    f'    {__name} = property(doc=_omit_signature(obj.{__name}.__doc__))'
                    for __name in vars(obj)
                    if isinstance(getattr(obj, __name), property)
                )
                src.extend((
                    '    __slots__ = ()',
                    '    __doc__ = obj.__doc__',
                    '    __mro__ = obj.__mro__',
                ))
                if hasattr(obj, '_non_zero_doc'):
                    src.extend((
                        '    def __bool__(self): pass',
                        '    __bool__.__doc__ = obj._non_zero_doc',
                    ))
                eval(compile('\n'.join(src), __file__, 'exec'))
