cdef tuple tuple_OutputSink_Buffer = (OutputSink, Buffer)
cdef tuple tuple_str_Path = (str, Path)


cdef object _DocumentEncoding

global DocumentEncoding

cdef object document_encoding_for_name(name):
    return _generic_id_for_name(_DocumentEncoding, name)

cdef enum DocumentEncodingEnum:
    DE_Ascii
    DE_AsciiBytes
    DE_Unicode
    DE_Utf8
    
_DocumentEncoding = IntEnum('DocumentEncoding', {
    'ascii': <unsigned int> DocumentEncodingEnum.DE_Ascii,
    'ascii_bytes': <unsigned int> DocumentEncodingEnum.DE_AsciiBytes,
    'unicode': <unsigned int> DocumentEncodingEnum.DE_Unicode,
    'utf8': <unsigned int> DocumentEncodingEnum.DE_Utf8,
})

_DocumentEncoding.for_name = document_encoding_for_name

DocumentEncoding = _DocumentEncoding


cdef boolean _document_set_options(
    Document document, object options,
    boolean quiet, boolean force_output, boolean body_only, boolean output_bom,
) except False:
    tidyOptSetInt(document.tidy_doc, TidyWrapLen, 2**30)

    if options:
        if isinstance(options, Document):
            document.options_copy_from(options)
        else:
            items = getattr(options, 'items', None)
            if items is not None:
                options = items()
                del items

            for key, value in options:
                try:
                    if not document.set_option_value(key, value):
                        raise Exception('The function reported an error for key=%r' % (key,))
                except Exception as ex:
                    raise Exception(f'Could not set {key!r}={value!r}') from ex

    tidyOptSetBool(document.tidy_doc, TidyQuiet, yes if quiet else no)
    tidyOptSetBool(document.tidy_doc, TidyForceOutput, yes if force_output else no)
    tidyOptSetBool(document.tidy_doc, TidyBodyOnly, yes if body_only else no)
    tidyOptSetBool(document.tidy_doc, TidyOutputBOM, yes if output_bom else no)

    return True


cdef boolean _document_parse(Document document, object text, str input_encoding) except False:
    if isinstance(text, unicode):
        if input_encoding is not None:
            raise ValueError('Unused parameter input_encoding')
        document.parse_string(text)
    else:
        Document._maybe_set_encoding(document.tidy_doc, input_encoding)
        if isinstance(text, InputSource):
            document.parse_input(text)
        elif isinstance(text, Buffer):
            document.parse_buffer(text)
        elif isinstance(text, int):
            document.parse_fd(text)
        elif isinstance(text, Path):
            document.parse_file(text)
        else:  # Assume text is bytes-like.
            document.parse_bytes(text)

    return True


cdef _document_save_buffer(Document document, object encoding, StringBuffer message_buffer):
    cdef DocumentEncodingEnum encoding_enum
    cdef StringBuffer output

    if encoding is not None:
        encoding_enum = <DocumentEncodingEnum> PyLong_AsLong(document_encoding_for_name(encoding))
    else:
        encoding_enum = DocumentEncoding.ascii

    tidySetOutCharEncoding(
        document.tidy_doc,
        b'ascii'   if encoding_enum is DocumentEncodingEnum.DE_Ascii else
        b'ascii'   if encoding_enum is DocumentEncodingEnum.DE_AsciiBytes else
        b'utf8'    if encoding_enum is DocumentEncodingEnum.DE_Unicode else
        b'utf8'  # if encoding_enum is DocumentEncodingEnum.DE_Utf8 else
    )

    output = StringBuffer(
        BufferTypeInSpe.Ascii   if encoding_enum is DocumentEncodingEnum.DE_Ascii else
        BufferTypeInSpe.Bytes   if encoding_enum is DocumentEncodingEnum.DE_AsciiBytes else
        BufferTypeInSpe.Utf8    if encoding_enum is DocumentEncodingEnum.DE_Unicode else
        BufferTypeInSpe.Bytes # if encoding_enum is DocumentEncodingEnum.DE_Utf8 else
    )

    document.save_sink(output)

    if message_buffer is not None:
        return output.release(), message_buffer.release()
    else:
        return output.release()


cdef _document_save_output(Document document, object encoding, StringBuffer message_buffer, object output):
    cdef object result

    if encoding is not None:
        document.set_output_encoding(encoding)
    else:
        tidySetOutCharEncoding(document.tidy_doc, b'utf8')

    if isinstance(output, tuple_OutputSink_Buffer):
        document.save_sink(output)
    elif isinstance(output, tuple_str_Path):
        document.save_file(output)
    elif isinstance(output, int):
        document.save_fd(output)
    else:
        raise TypeError('Cannot determine output location')

    if message_buffer is not None:
        return output, message_buffer.release()
    else:
        return output


cdef _tidy_document(
    object text, object options, object encoding,
    object message_callback, str input_encoding, object output,
    boolean quiet, boolean force_output, boolean body_only, boolean output_bom,
):
    cdef Document document = Document()
    cdef StringBuffer message_buffer

    if not quiet:
        message_buffer = StringBuffer('utf8')
        document.set_error_sink(message_buffer)
    else:
        message_buffer = None
        document.set_error_sink(VoidSink())

    _document_set_options(document, options, quiet, force_output, body_only, output_bom)

    if message_callback is not None:
        document._set_message_callback(message_callback)

    _document_parse(document, text, input_encoding)

    document.clean_and_repair()

    if output is None:
        return _document_save_buffer(document, encoding, message_buffer)
    else:
        return _document_save_output(document, encoding, message_buffer, output)


def tidy_document(
    input,
    *,
    options=None,
    output=None,
    encoding=_DocumentEncoding.ascii,
    boolean output_bom=False,
    boolean quiet=False,
    boolean force_output=True,
    message_callback=None,
    str input_encoding=None,
    boolean body_only=False,
):
    '''
    Tidy up a document.

    Arguments
    ---------
    input : str | bytes-like | InputSource | Buffer | int
        * ``str | bytes-like``: HTML source to tidy up
        * ``InputSource | Buffer``: An object that contains the HTML source.
        * ``int``: A non-negative number is assumed to be a file descriptor.
    options : Mapping[OptionId, value] | Iterable[(OptionId, value)] | :class:`pytidyhtml5.Document`
        * A list or dictionary of :class:`pytidyhtml5.OptionId`/value pairs.
        * A document for apply :func:`pytidyhtml5.Document.options_copy_to` on.
    output : None | OutputSink | Buffer | Path | str | int
        * ``None``: The function returns an ``str`` or ``bytes`` object according to the parameter ``encoding``.
        * ``OutputSink | Buffer``: The output is dumped into the argument.
        * ``Path | str``: The output is written into said file path.
        * ``int``: The non-negative number is assumed to be file descriptor. The output is written into the handle.
    output_bom : bool
        Add a byte-order-mark to the output.
    encoding : str | int | DocumentEncoding
        * If ``output is None``:

            * ``"ascii"``: Returns an ``str()`` that contains only US-ASCII data.
            * ``"unicode"``: Returns an ``str()`` that contains full unicode data.
            * ``"utf8"``: Returns ``bytes()`` encoded as UTF-8.

        * If ``output is not None``: :method:`Document.set_output_encoding` gets called.
    quiet : bool
        Suppress messages if true
    force_output : bool
        Always return an output even if the input is severely messed up.
    message_callback : callable
        Function to call if there are messages while parsing
    input_encoding : str | None
        * Specify the input-encoding if ``input`` is not an ``str``.
        * Must be None otherwise.
    body_only : bool
        Only dump the body fragment of the document.

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
    return _tidy_document(
        input, options, encoding,
        message_callback, input_encoding, output,
        quiet, force_output, body_only, output_bom,
    )


def tidy_fragment(
    input,
    *,
    options=None,
    output=None,
    encoding=_DocumentEncoding.ascii,
    boolean output_bom=False,
    boolean quiet=False,
    boolean force_output=True,
    message_callback=None,
    str input_encoding=None,
    boolean body_only=True,
):
    return _tidy_document(
        input, options, encoding,
        message_callback, input_encoding, output,
        quiet, force_output, body_only, output_bom,
    )
