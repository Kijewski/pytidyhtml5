import _pytidyhtml5

from _pytidyhtml5 import *
from ._doc import BUILDING_DOC


_tidy_document_string_buffer_encoding = {
    'ascii': BufferType.ascii,   # ascii   - ASCII in an str()
    'unicode': BufferType.utf8,  #  - Unicode in as str()
    'utf8': BufferType.bytes,    #     - UTF-8 in bytes()
}

_tidy_document_string_output_encoding = {
    'ascii': 'ascii',
    'unicode': 'utf8',
    'utf8': 'utf8',
}


def tidy_document(text, options=None, *, quiet=False, force_output=True, encoding='ascii'):
    '''
    Tidy up a document.

    Arguments
    ---------
    text : str
        Source code to tidy up
    options : Mapping[OptionId, value] | Iterable[(OptionId, value)] | :class:`pytidyhtml5.Document`
        * A list or dictionary of :class:`pytidyhtml5.OptionId`/value pairs.
        * A document for apply :func:`pytidyhtml5.Document.options_copy_to` on.
    quite : bool
        Suppress messages if true
    force_output : bool
        Always return an output even if the input is severely messed up.
    encoding : str
        * ``"ascii"``: Returns an ``str()`` that contains only US-ASCII data.
        * ``"unicode"``: Returns an ``str()`` that contains full unicode data.
        * ``"utf8"``: Returns ``bytes()`` encoded as UTF-8.

    Returns
    -------
    tuple[str, str]
        If ``not quiet`` and ``encoding != "utf8"``
    tuple[bytes, str]
        If ``not quiet`` and ``encoding == "utf8"``
    str
        If ``quiet`` and ``encoding != "utf8"``
    bytes
        If ``quiet`` and ``encoding == "utf8"``
    '''
    quiet = bool(quiet)
    force_output = bool(force_output)

    result = StringBuffer(_tidy_document_string_buffer_encoding[encoding])
    messages = StringBuffer('utf8') if not quiet else VoidSink()

    document = Document()
    document.set_error_sink(messages)

    document.set_option_value(OptionId.wrap_len, 2**20)
    if options:
        if isinstance(options, Document):
            document.options_copy_from(options)
        else:
            if hasattr(options, 'items'):
                options = options.items()
            for key, value in options:
                try:
                    if not document.set_option_value(key, value):
                        raise Exception('The function reported an error')
                except Exception as ex:
                    raise Exception(f'Could not set {key!r}={value!r}') from ex

    document.set_option_value(OptionId.quiet, quiet)
    document.set_option_value(OptionId.output_bom, False)

    outcome = document.parse_string(text)
    if (outcome is ParseOutcome.errors) and (not force_output):
        raise Exception('Could not parse text:\n' + messages.release())

    document.set_output_encoding(_tidy_document_string_output_encoding[encoding])
    document.set_option_value(OptionId.force_output, force_output)
    document.save_sink(result)

    if not quiet:
        return result.release(), messages.release()
    else:
        return result.release()


__all__ = (
    *_pytidyhtml5.__all__,
    'tidy_document',
)

__version__ = _pytidyhtml5.__version__


if BUILDING_DOC:
    from enum import IntEnum

    def _omit_signature(doc):
        if doc:
            return '\n\n'.join(doc.split('\n\n', 1)[1:]).strip()
    
    for name in _pytidyhtml5.__all__:
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
