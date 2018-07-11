import _pytidyhtml5

from _pytidyhtml5 import *
from ._doc import BUILDING_DOC


def tidy_document(text, options=None):
    messages = _pytidyhtml5.StringBuffer('utf8')
    result = _pytidyhtml5.StringBuffer('ascii')

    document = _pytidyhtml5.Document()
    document.set_error_sink(messages)

    if document.parse_string(text) is _pytidyhtml5.ParseOutcome.Errors:
        raise Exception('Could not parse text:\n' + messages.release())

    document.set_option_value('OutputBOM', False)
    document.set_option_value('Wrap', 2**20)
    if options:
        for key, value in options:
            if not document.set_option_value(key, value):
                raise Exception(f'Could not set {key!r}={value!r}')

    document.set_output_encoding('ascii')
    document.save_sink(result)

    return result.release(), messages.release()


__all__ = (
    *_pytidyhtml5.__all__,
    'tidy_document',
)

__version__ = _pytidyhtml5.__version__


if BUILDING_DOC:
    from enum import IntEnum
    
    for name in _pytidyhtml5.__all__:
        obj = getattr(_pytidyhtml5, name)
        if isinstance(obj, type) and issubclass(obj, IntEnum):
            src = [f'class {name}(IntEnum):']
            src.extend(
                f'    {__elem.name} = {int(__elem)}'
                for __elem in obj
            )
            src.append(f'X = {name}')
            eval(compile('\n'.join(src), __file__, 'exec'))
            X.__doc__ = obj.__doc__
