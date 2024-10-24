cdef object _ParseOutcome

global ParseOutcome

cdef object parse_outcome_for_name(name):
    return _generic_id_for_name(_ParseOutcome, name)

_ParseOutcome = IntEnum('ParseOutcome', {
    'ok': 0,
    'warnings': 1,
    'errors': 2,
})

_ParseOutcome.for_name = parse_outcome_for_name

ParseOutcome = _ParseOutcome


@final
@no_gc
@auto_pickle(False)
cdef class DocumentIterOptions:
    cdef TidyIterator tidy_iterator
    cdef readonly Document document

    def __cinit__(DocumentIterOptions self):
        self.tidy_iterator = NULL

    def __init__(DocumentIterOptions self, Document document):
        cdef TidyDoc tidy_doc
        cdef TidyIterator tidy_iterator

        if document is not None:
            tidy_doc = document.tidy_doc
            if tidy_doc is not NULL:
                tidy_iterator = tidyGetOptionList(tidy_doc)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.document = document

    cdef boolean _nonzero__(DocumentIterOptions self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentIterOptions self):
        return self._nonzero()

    def __iter__(DocumentIterOptions self):
        return self

    def __next__(DocumentIterOptions self):
        cdef TidyDoc tidy_doc
        cdef TidyOption tidy_option
        cdef Option option
        cdef Document document = self.document

        if document is not None:
            tidy_doc = document.tidy_doc
            if tidy_doc is not NULL:
                while self.tidy_iterator is not NULL:
                    tidy_option = tidyGetNextOption(tidy_doc, &self.tidy_iterator)
                    if tidy_option is not NULL:
                        option = Option(document)
                        option.tidy_option = tidy_option
                        return option

        self.document = None
        self.tidy_iterator = NULL

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class DocumentIterOptionIds:
    cdef TidyIterator tidy_iterator
    cdef readonly Document document

    def __cinit__(DocumentIterOptionIds self, Document document):
        self.tidy_iterator = NULL

    def __init__(DocumentIterOptionIds self, Document document):
        cdef TidyDoc tidy_doc
        cdef TidyIterator tidy_iterator
        if document is not None:
            tidy_doc = document.tidy_doc
            if tidy_doc is not NULL:
                tidy_iterator = tidyGetOptionList(tidy_doc)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.document = document

    cdef inline boolean _nonzero(DocumentIterOptionIds self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentIterOptionIds self):
        return self._nonzero()

    def __iter__(DocumentIterOptionIds self):
        return self

    def __next__(DocumentIterOptionIds self):
        cdef TidyDoc tidy_doc
        cdef TidyOption tidy_option
        cdef Option option
        cdef Document document = self.document

        if document is not None:
            tidy_doc = document.tidy_doc
            if tidy_doc is not NULL:
                while self.tidy_iterator is not NULL:
                    tidy_option = tidyGetNextOption(tidy_doc, &self.tidy_iterator)
                    if tidy_option is not NULL:
                        return _GetEnum[TidyOption, TidyOptionId]._do(tidy_option, tidyOptGetId, _OptionId)

        self.document = None
        self.tidy_iterator = NULL

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class DocumentIterDeclTags:
    cdef TidyIterator tidy_iterator
    cdef readonly Document document
    cdef readonly long option_id

    def __cinit__(DocumentIterDeclTags self, Document document, object option):
        self.tidy_iterator = NULL
        self.option_id = -1

    def __init__(DocumentIterDeclTags self, Document document, object option):
        cdef TidyDoc tidy_doc
        cdef TidyIterator tidy_iterator
        cdef long option_id
        if (document is not None) and isinstance(option, _OptionId):
            tidy_doc = document.tidy_doc
            option_id = PyLong_AsLong(option)
            if tidy_doc is not NULL:
                tidy_iterator = tidyOptGetDeclTagList(tidy_doc)
                if tidy_iterator is not NULL:
                    self.tidy_iterator = tidy_iterator
                    self.document = document
                    self.option_id = option_id

    cdef inline boolean _nonzero(DocumentIterDeclTags self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentIterDeclTags self):
        return self._nonzero()

    def __iter__(DocumentIterDeclTags self):
        return self

    def __next__(DocumentIterDeclTags self):
        cdef TidyDoc tidy_doc
        cdef TidyOption tidy_option
        cdef ctmbstr text
        cdef size_t length
        cdef Document document = self.document

        if document is not None:
            tidy_doc = document.tidy_doc
            if tidy_doc is not NULL:
                while self.tidy_iterator is not NULL:
                    text = tidyOptGetNextDeclTag(tidy_doc, <TidyOptionId> self.option_id, &self.tidy_iterator)
                    if text is not NULL:
                        length = strlen(text)
                        return PyUnicode_DecodeUTF8(text, length, b'replace')

        self.tidy_iterator = NULL
        self.document = None
        self.option_id = -1

        raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class DocumentOptionsProxy:
    cdef readonly Document document

    def __cinit__(DocumentOptionsProxy self, Document document):
        self.document = document

    cdef inline boolean _nonzero(DocumentOptionsProxy self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentOptionsProxy self):
        return self._nogil()

    def __iter__(DocumentOptionsProxy self):
        return DocumentIterOptionIds(self.document)

    def __getitem__(DocumentOptionsProxy self, id):
        cdef Document document = self.document
        cdef Option option

        if not document:
            raise KeyError('Document is dead')

        try:
            option = document.get_option(id)
        except Exception as ex:
            raise KeyError from ex

        if option is None:
            raise KeyError

        return option.get_value()

    def __setitem__(DocumentOptionsProxy self, id, value):
        cdef Document document = self.document
        cdef Option option

        if not document:
            raise KeyError('Document is dead')

        try:
            option = document.get_option(id)
        except Exception as ex:
            raise KeyError from ex

        if option is None:
            raise KeyError

        option.set_value(value)

    def __delitem__(DocumentOptionsProxy self, id):
        cdef Document document = self.document
        cdef Option option

        if not document:
            raise KeyError('Document is dead')

        try:
            option = document.get_option(id)
        except Exception as ex:
            raise KeyError from ex

        if (option is None) or (option.reset() is not True):
            raise KeyError


cdef document_iter_ctmbstr_init(Document document, TidyIterator *out_tidy_iterator, TidyIterator fn(TidyDoc) noexcept nogil):
    cdef TidyDoc tidy_doc
    cdef TidyIterator tidy_iterator

    out_tidy_iterator[0] = NULL

    if document is not None:
        tidy_doc = document.tidy_doc
        if tidy_doc is not NULL:
            tidy_iterator = tidyOptGetPriorityAttrList(tidy_doc)
            if tidy_iterator is not NULL:
                out_tidy_iterator[0] = tidy_iterator
                return document


cdef _result_to_outcome(int result):
    cdef object parse_outcome = result

    if 0 <= result <= 2:
        parse_outcome = _ParseOutcome(result)

    return parse_outcome


cdef document_iter_ctmbstr_next(PyObject **document, TidyIterator *tidy_iterator, ctmbstr fn(TidyDoc, TidyIterator*) noexcept nogil):
    cdef TidyDoc tidy_doc
    cdef TidyOption tidy_option
    cdef ctmbstr text
    cdef size_t length

    if document[0] is not Py_None:
        tidy_doc = (<Document> document[0]).tidy_doc
        if tidy_doc is not NULL:
            while tidy_iterator[0] is not NULL:
                text = fn(tidy_doc, tidy_iterator)
                if text is not NULL:
                    length = strlen(text)
                    return PyUnicode_DecodeUTF8(text, length, b'replace')

    Py_XINCREF(Py_None)
    Py_XDECREF(document[0])
    document[0] = Py_None

    tidy_iterator[0] = NULL

    raise StopIteration


@final
@no_gc
@auto_pickle(False)
cdef class DocumentIterPriorityAttrs:
    cdef TidyIterator tidy_iterator
    cdef readonly Document document

    def __cinit__(DocumentIterPriorityAttrs self, Document document):
        self.document = document_iter_ctmbstr_init(document, &self.tidy_iterator, tidyOptGetPriorityAttrList)

    cdef inline boolean _nonzero(DocumentIterPriorityAttrs self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is not NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentIterPriorityAttrs self):
        return self._nonzero()

    def __iter__(DocumentIterPriorityAttrs self):
        return self

    def __next__(DocumentIterPriorityAttrs self):
        return document_iter_ctmbstr_next(
            ref_document[DocumentIterPriorityAttrs](<PyObject*> self),
            &self.tidy_iterator,
            tidyOptGetNextPriorityAttr,
        )


@final
@no_gc
@auto_pickle(False)
cdef class DocumentIterMutedMessages:
    cdef TidyIterator tidy_iterator
    cdef readonly Document document

    def __cinit__(DocumentIterMutedMessages self, Document document):
        self.document = document_iter_ctmbstr_init(document, &self.tidy_iterator, tidyOptGetMutedMessageList)

    cdef inline boolean _nonzero(DocumentIterMutedMessages self) noexcept nogil:
        if self is None:
            return False
        elif self.tidy_iterator is NULL:
            return False
        else:
            return self.document._nonzero()

    def __nonzero__(DocumentIterMutedMessages self):
        return self._nonzero()

    def __iter__(DocumentIterMutedMessages self):
        return self

    def __next__(DocumentIterMutedMessages self):
        return document_iter_ctmbstr_next(
            ref_document[DocumentIterPriorityAttrs](<PyObject*> self),
            &self.tidy_iterator,
            tidyOptGetNextMutedMessage,
        )


cdef object _path_to_string(object path, char **string, Py_ssize_t *length):
    if not isinstance(path, PurePath):
        path = Path(path)

    if isinstance(path, PosixPath):
        path = bytes(path)
        PyBytes_AsStringAndSize(path, string, length)
    elif isinstance(path, WindowsPath):
        path = unicode(path)
        string[0] = <char*> PyUnicode_AsUTF8AndSize(path, length)
    else:
        raise RuntimeError('Argument is neither PosixPath nor WindowsPath')

    return path


@final
@no_gc
@auto_pickle(False)
cdef class Document:
    cdef TidyDoc tidy_doc
    cdef readonly object error_sink
    cdef readonly object _message_callback
    cdef readonly boolean is_parsed

    def __cinit__(Document self):
        cdef TidyDoc tidy_doc = tidyCreateWithAllocator(&allocator_raw)

        if tidy_doc is NULL:
            NoMemoryThrow()

        tidySetAppData(tidy_doc, <void*> self)
        self.tidy_doc = tidy_doc
        self.is_parsed = False

    def __dealloc__(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        self.tidy_doc = NULL
        if tidy_doc is not NULL:
            tidyRelease(tidy_doc)

    cdef inline boolean _nonzero(Document self) noexcept nogil:
        if self is None:
            return False
        else:
            return self.tidy_doc is not NULL

    def __nonzero__(Document self):
        return self._nonzero()

    def __repr__(Document self):
        cdef uintptr_t addr = <uintptr_t> <void*> self.tidy_doc
        if addr != 0:
            return f'<Document @ 0x{addr:x}>'
        else:
            return f'<Document>'

    def __eq__(Document self, other):
        if type(self) is not type(self):
            return NotImplemented
        else:
            return (self.tidy_doc is not NULL) and (self.tidy_doc is (<Document> other).tidy_doc)

    def __ne__(Document self, other):
        if type(self) is not type(other):
            return NotImplemented
        else:
            return (self.tidy_doc is NULL) or (self.tidy_doc is not (<Document> other).tidy_doc)

    cdef object __get(Document self, TidyNode fn(TidyDoc) noexcept nogil):
        cdef Node result
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef TidyNode tidy_node = NULL

        if tidy_doc is not NULL:
            tidy_node = fn(tidy_doc)
            if tidy_node is not NULL:
                result = Node(self)
                result.tidy_node = tidy_node
                return result

    cpdef get_root(Document self):
        return self.__get(tidyGetRoot)

    cpdef get_html(Document self):
        return self.__get(tidyGetHtml)

    cpdef get_head(Document self):
        return self.__get(tidyGetHead)

    cpdef get_body(Document self):
        return self.__get(tidyGetBody)

    cpdef get_status(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyStatus(tidy_doc)

    cpdef get_detected_html_version(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyDetectedHtmlVersion(tidy_doc)

    cpdef get_detected_xhtml(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyDetectedXhtml(tidy_doc) != 0

    cpdef get_detected_generic_xml(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyDetectedGenericXml(tidy_doc) != 0

    cpdef get_error_count(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyWarningCount(tidy_doc)

    cpdef get_warning_count(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL and tidyGetHtml(tidy_doc) is not NULL:
            return tidyWarningCount(tidy_doc)

    cpdef clean_and_repair(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result
        if tidy_doc is not NULL:
            with nogil:
                result = tidyCleanAndRepair(tidy_doc)
            return _result_to_outcome(result)

    def run_diagnostics(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result
        if tidy_doc is not NULL:
            with nogil:
                result = tidyCleanAndRepair(tidy_doc)
            return result

    def report_doctype(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result
        if tidy_doc is not NULL:
            with nogil:
                result = tidyReportDoctype(tidy_doc)
            return result

    cpdef save_file(Document self, filename):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef char *path = NULL
        cdef Py_ssize_t length = 0
        cdef int result

        if tidy_doc is NULL:
            return

        filename = _path_to_string(filename, &path, &length)
        with nogil:
            result = tidySaveFile(tidy_doc, path)

        return result == 0

    def save_stdout(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result
        if tidy_doc is not NULL:
            with nogil:
                result = tidySaveStdout(tidy_doc)
            return result

    cpdef save_sink(Document self, arg):
        cdef int result
        cdef TidyDoc tidy_doc
        cdef TidyBuffer tidy_buffer
        cdef TidyOutputSink tidy_sink

        tidy_doc = self.tidy_doc
        if tidy_doc is NULL:
            return

        if arg is None:
            raise TypeError('Argument cannot be None')
        elif not arg:
            raise ValueError('Argument cannot be falsy')
        elif isinstance(arg, Buffer):
            with nogil:
                result = tidySaveBuffer(tidy_doc, &(<Buffer> arg).tidy_buffer)
        elif isinstance(arg, OutputSink):
            with nogil:
                result = tidySaveSink(tidy_doc, &(<OutputSink> arg).tidy_sink)
        else:
            raise TypeError('Argument is neither Buffer nor OutputSink')

        return _result_to_outcome(result)

    cpdef save_fd(Document self, fd, encoding=None):
        # Do not release or overwrite fd.
        # It could close the file descriptor if fd is a File.
        cdef object fileno = getattr(fd, 'fileno', None)
        cdef int handle

        if fileno is not None:
            if callable(fileno):
                handle = fileno()
            else:
                handle = fileno
        else:
            handle = fd

        return self.save_sink(FiledescriptorSink(handle))

    def save_bytes(Document self, arg=BufferTypeInSpe.Bytes):
        cdef StringBuffer buf = self.save_buffer(arg)
        if buf is not None:
            return buf.release()

    cpdef save_buffer(Document self, arg=None):
        cdef StringBuffer buf
        if self:
            buf = StringBuffer(arg)
            self.save_sink(buf)
            return buf

    def save_options_file(Document self, path):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef char *string = NULL
        cdef Py_ssize_t length = 0
        cdef int result

        if tidy_doc is NULL:
            return

        path = _path_to_string(path, &string, &length)
        with nogil:
            result = tidyOptSaveFile(tidy_doc, string)

        return result

    def save_options_sink(Document self, arg):
        cdef TidyOutputSink output_sink
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return

        if arg is None:
            raise TypeError('Argument cannot be None')
        elif not arg:
            raise ValueError('Argument cannot be falsy')
        elif isinstance(arg, OutputSink):
            with nogil:
                result = tidyOptSaveSink(tidy_doc, &(<OutputSink> arg).tidy_sink)
        elif isinstance(arg, Buffer):
            tidyInitOutputBuffer(&output_sink, &(<Buffer> arg).tidy_buffer)
            with nogil:
                result = tidyOptSaveSink(tidy_doc, &output_sink)
        else:
            raise TypeError('Argument is neither Buffer nor OutputSink')

        return _result_to_outcome(result)

    def iter_options(Document self):
        return DocumentIterOptions(self)

    cdef PythonBool _set_option_ulong(Document self, TidyOptionId opt_id, ulong value):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL:
            return tidyOptSetInt(tidy_doc, opt_id, value) is not no

    cdef PythonBool _set_option_bool(Document self, TidyOptionId opt_id, boolean value):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL:
            return tidyOptSetBool(tidy_doc, opt_id, yes if value else no) is not no

    cdef PythonBool _set_option_str(Document self, TidyOptionId opt_id, const char *value):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is NULL:
            return

        return tidyOptSetValue(tidy_doc, opt_id, value) is not no

    cdef PythonBool _set_option_str_object(Document self, TidyOptionId opt_id, object value):
        cdef char *string = NULL
        cdef Py_ssize_t length = 0

        if isinstance(value, unicode):
            string = <char*> PyUnicode_AsUTF8AndSize(value, &length)
        elif isinstance(value, bytes):
            PyBytes_AsStringAndSize(value, &string, &length)
        else:
            raise TypeError

        return self._set_option_str(opt_id, string)

    cpdef get_option(Document self, name):
        cdef TidyOption tidy_option
        cdef Option option
        cdef object option_id = OptionId.for_name(name)
        cdef TidyDoc tidy_doc = self.tidy_doc
        
        if (tidy_doc is NULL) or (option_id is None):
            return

        tidy_option = tidyGetOption(tidy_doc, <TidyOptionId> PyLong_AsLong(option_id))
        if tidy_option is not NULL:
            option = Option(self)
            option.tidy_option = tidy_option
            return option

    def get_option_value(Document self, name):
        cdef Option option = self.get_option(name)
        if option is not None:
            return option.get_value()

    def get_option_default(Document self, name):
        cdef Option option = self.get_option(name)
        if option is not None:
            return option.get_default()

    def set_option_value(Document self, name, value):
        cdef Option option = self.get_option(name)
        if option is not None:
            return option.set_value(value)

    def reset_option(Document self, name):
        cdef Option option = self.get_option(name)
        if option is not None:
            return option.reset()

    def reset_options(Document self):
        return _bool_fn(self.tidy_doc, tidyOptResetAllToDefault)

    def snapshot_options(Document self):
        return _bool_fn(self.tidy_doc, tidyOptSnapshot)

    def snapshot_reset(Document self):
        return _bool_fn(self.tidy_doc, tidyOptResetToSnapshot)

    def options_diff_default(Document self):
        return _bool_fn(self.tidy_doc, tidyOptDiffThanDefault)

    def options_diff_snapshot(Document self):
        return _bool_fn(self.tidy_doc, tidyOptDiffThanSnapshot)

    cpdef options_copy_to(Document self, Document other):
        cdef TidyDoc dest_doc
        cdef TidyDoc source_doc = self.tidy_doc

        if (source_doc is NULL) or (other is None):
            return

        dest_doc = other.tidy_doc
        if source_doc is dest_doc:
            return

        return _bool_fn[TidyDoc, TidyDoc](other.tidy_doc, tidyOptCopyConfig, source_doc)

    def options_copy_from(Document self, Document other):
        if other is not None:
            return other.options_copy_to(self)

    def dump_error_summary(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL:
            tidyErrorSummary(tidy_doc)
            return True

    def dump_general_info(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL:
            tidyGeneralInfo(tidy_doc)
            return True

    def iter_decl_tags(Document self, option):
        return DocumentIterDeclTags(self, option_id_for_name(option))

    def iter_prority_attr(Document self):
        return DocumentIterPriorityAttrs(self)

    def iter_mutex_messages(Document self):
        return DocumentIterMutedMessages(self)

    cpdef set_error_sink(self, arg):
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc
        if tidy_doc is not NULL:
            if arg is None:
                arg = VoidSink()

            if isinstance(arg, Buffer):
                with nogil:
                    result = tidySetErrorBuffer(tidy_doc, &(<Buffer> arg).tidy_buffer)
            elif isinstance(arg, OutputSink):
                with nogil:
                    result = tidySetErrorSink(tidy_doc, &(<OutputSink> arg).tidy_sink)
            else:
                raise TypeError

            self.error_sink = arg

            return result

    cdef object _parse_input_source(Document self, TidyInputSource *input_source):
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return
        elif input_source is NULL:
            raise TypeError
        elif self.is_parsed:
            raise Exception('Document was already parsed')

        try:
            with nogil:
                result = tidyParseSource(tidy_doc, input_source)
            return _result_to_outcome(result)
        finally:
            self.is_parsed = True

    cpdef parse_string(Document self, unicode data):
        cdef SourceData source_data = SourceData(
            0, NULL,
            <int> EndOfStream, 3, utf8_bom,
        )
        cdef TidyInputSource input_source
        cdef int input_kind
        cdef int (*get_fun)(void *sourceData_) noexcept nogil
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return

        PyUnicode_READY(data)
        source_data.remaining = PyUnicode_GET_LENGTH(data)
        source_data.string = <unsigned char*> PyUnicode_DATA(data)

        if PyUnicode_IS_ASCII(data):
            get_fun = asciiGetByteFunc
        else:
            input_kind = PyUnicode_KIND(data)
            if input_kind == PyUnicode_1BYTE_KIND:
                get_fun = ucs1GetByteFunc
            elif input_kind == PyUnicode_2BYTE_KIND:
                get_fun = ucs2GetByteFunc
            elif input_kind == PyUnicode_4BYTE_KIND:
                get_fun = ucs4GetByteFunc
            else:
                raise SystemError

        result = tidySetInCharEncoding(tidy_doc, b'utf8')
        if result != 0:
            raise SystemError

        input_source = TidyInputSource(&source_data, get_fun, ungetByteFunc, eofFunc)
        return self._parse_input_source(&input_source)

    cpdef parse_input(Document self, InputSource source):
        if source is None:
            raise TypeError

        return self._parse_input_source(&source.input_source)

    @staticmethod
    cdef boolean _maybe_set_encoding(TidyDoc tidy_doc, encoding) except False:
        cdef char *encoding_string = NULL
        cdef Py_ssize_t encoding_size = 0

        if encoding is not None:
            encoding_string = <char*> PyUnicode_AsUTF8AndSize(encoding, &encoding_size)
            result = tidySetInCharEncoding(tidy_doc, encoding_string)
            if result != 0:
                raise ValueError('Encoding not understood')

        return True

    cpdef parse_bytes(Document self, data, encoding=None):
        cdef Py_buffer view
        cdef int result
        cdef TidyBuffer tidy_buffer
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return
        elif self.is_parsed:
            raise Exception('Document was already parsed')

        PyObject_GetBuffer(data, &view, PyBUF_CONTIG_RO)
        try:
            try:
                Document._maybe_set_encoding(tidy_doc, encoding)
                with nogil:
                    tidyBufInitWithAllocator(&tidy_buffer, &allocator_raw)
                    tidyBufAttach(&tidy_buffer, <byte*> view.buf, view.len)
                    result = tidyParseBuffer(tidy_doc, &tidy_buffer)
                    tidyBufDetach(&tidy_buffer)
                return _result_to_outcome(result)
            finally:
                self.is_parsed = True
        finally:
            PyBuffer_Release(&view)

    cpdef parse_buffer(Document self, Buffer buf, encoding=None):
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return
        elif buf is None:
            raise TypeError
        elif self.is_parsed:
            raise Exception('Document was already parsed')

        try:
            Document._maybe_set_encoding(tidy_doc, encoding)
            with nogil:
                result = tidyParseBuffer(tidy_doc, &buf.tidy_buffer)
            return _result_to_outcome(result)
        finally:
            self.is_parsed = True

    cpdef parse_file(Document self, path, encoding=None):
        cdef char *string = NULL
        cdef Py_ssize_t length = 0
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return
        elif self.is_parsed:
            raise Exception('Document was already parsed')

        path = _path_to_string(path, &string, &length)

        try:
            Document._maybe_set_encoding(tidy_doc, encoding)
            with nogil:
                result = tidyParseFile(tidy_doc, string)
            return _result_to_outcome(result)
        finally:
            self.is_parsed = True

    cpdef parse_fd(Document self, fd, encoding=None):
        # Do not release or overwrite fd.
        # It could close the file descriptor if fd is a File.
        cdef object fileno = getattr(fd, 'fileno', None)
        cdef int handle

        if fileno is not None:
            if callable(fileno):
                handle = fileno()
            else:
                handle = fileno
        else:
            handle = fd

        return self.parse_input(FiledescriptorSource(handle))

    @property
    def option(Node self):
        return DocumentOptionsProxy(self)

    cdef _set_message_callback(self, value):
        cdef TidyDoc tidy_doc = self.tidy_doc
        if value is not None:
            if tidy_doc is not NULL:
                tidySetMessageCallback(tidy_doc, Document.message_callback_nogil)
            self._message_callback = value
        elif self._message_callback is not None:
            if tidy_doc is not NULL:
                tidySetMessageCallback(tidy_doc, _reinterpret_cast[TidyMessageCallback, voidp](NULL))
            self._message_callback = None

    @property
    def message_callback(self):
        return self._message_callback

    @message_callback.setter
    def message_callback(self, value):
        self._set_message_callback(value)

    @staticmethod
    cdef Bool message_callback_nogil(TidyMessage tidy_message) noexcept nogil:
        cdef TidyDoc tidy_doc = tidyGetMessageDoc(tidy_message)
        cdef void *app_data

        if tidy_doc is not NULL:
            app_data = tidyGetAppData(tidy_doc)
            if app_data is not NULL:
                with gil:
                    return (<Document> app_data).message_callback_gil(tidy_message)

        return yes

    cdef Bool message_callback_gil(Document self, TidyMessage tidy_message):
        cdef int result = 1
        cdef object callback = self._message_callback
        cdef Message message = Message(self)

        if callback is not None:
            message.tidy_message = tidy_message
            result = call_bool_fn_1(callback, message)
            message.tidy_message = NULL

        if result > 0:
            return yes
        elif result == 0:
            return no
        else:
            # callback had an exception
            return yes

    def load_config_file(Document self, configfile, encoding=None):
        cdef char *configfile_string = NULL
        cdef Py_ssize_t configfile_size = 0
        cdef char *encoding_string = NULL
        cdef Py_ssize_t encoding_size = 0
        cdef int result
        cdef TidyDoc tidy_doc = self.tidy_doc

        if tidy_doc is NULL:
            return

        configfile = _path_to_string(configfile, &configfile_string, &configfile_size)

        if encoding is not None:
            encoding_string = <char*> PyUnicode_AsUTF8AndSize(encoding, &encoding_size)
        else:
            encoding_string = NULL

        with nogil:
            if encoding_string is not NULL:
                result = tidyLoadConfigEnc(tidy_doc, configfile_string, encoding_string)
            else:
                result = tidyLoadConfig(tidy_doc, configfile_string)

        return result == 0

    cpdef set_output_encoding(Document self, encoding):
        cdef char *string = NULL
        cdef Py_ssize_t length = 0
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result

        if tidy_doc is NULL:
            return

        string = <char*> PyUnicode_AsUTF8AndSize(encoding, &length)
        result = tidySetOutCharEncoding(tidy_doc, string)

        return result == 0

    def run_diagnostics(Document self):
        cdef TidyDoc tidy_doc = self.tidy_doc
        cdef int result
    
        if tidy_doc is NULL:
            return
    
        with nogil:
            result = tidyRunDiagnostics(tidy_doc)
        return _result_to_outcome(result)

    root = property(get_root)
    html = property(get_html)
    head = property(get_head)
    body = property(get_body)
    status = property(get_status)
    detected_html_version = property(get_detected_html_version)
    detected_xhtml = property(get_detected_xhtml)
    detected_generic_xml = property(get_detected_generic_xml)
    error_count = property(get_error_count)
    warning_count = property(get_warning_count)
