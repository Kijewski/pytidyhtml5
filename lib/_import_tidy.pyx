cdef extern from 'tidy.h' nogil:
    ctypedef struct TidyAllocator

    ctypedef void *__allocator_alloc(TidyAllocator *self, size_t nBytes) noexcept
    ctypedef void *__allocator_realloc(TidyAllocator *self, void *block, size_t nBytes) noexcept
    ctypedef void __allocator_free(TidyAllocator *self, void *block) noexcept
    ctypedef void __allocator_panic(TidyAllocator *self, ctmbstr msg) noexcept

    ctypedef struct TidyAllocatorVtbl:
        __allocator_alloc alloc
        __allocator_realloc realloc
        __allocator_free free
        __allocator_panic panic

    ctypedef struct TidyAllocator:
        const TidyAllocatorVtbl *vtbl

    ctypedef int TidyGetByteFunc(void *sourceData) noexcept
    ctypedef void TidyUngetByteFunc(void *sourceData, byte bt) noexcept
    ctypedef Bool TidyEOFFunc(void *sourceData) noexcept

    ctypedef void TidyPutByteFunc(void *sinkData, byte bt) noexcept

    ctypedef struct TidyInputSource:
        void *sourceData
        TidyGetByteFunc getByte
        TidyUngetByteFunc ungetByte
        TidyEOFFunc eof

    ctypedef struct TidyOutputSink:
        void *sinkData
        TidyPutByteFunc putByte

    enum:
        EndOfStream

    ctypedef struct __TidyDoc
    ctypedef struct __TidyOption
    ctypedef struct __TidyNode
    ctypedef struct __TidyAttr
    ctypedef struct __TidyMessage
    ctypedef struct __TidyMessageArgument

    ctypedef __TidyDoc *TidyDoc
    ctypedef __TidyOption *TidyOption
    ctypedef __TidyNode *TidyNode
    ctypedef __TidyAttr *TidyAttr
    ctypedef __TidyMessage *TidyMessage
    ctypedef __TidyMessageArgument *TidyMessageArgument

    ctmbstr tidyReleaseDate() noexcept
    ctmbstr tidyLibraryVersion() noexcept
    ctmbstr tidyPlatform() noexcept

    Bool tidySetLanguage(ctmbstr languageCode) noexcept
    ctmbstr tidyGetLanguage() noexcept

    ctypedef Bool TidyMessageCallback(TidyMessage tmessage) noexcept

    # Document

    ctypedef struct TidyBuffer

    TidyNode tidyGetRoot(TidyDoc tdoc)
    TidyNode tidyGetHtml(TidyDoc tdoc)
    TidyNode tidyGetHead(TidyDoc tdoc)
    TidyNode tidyGetBody(TidyDoc tdoc)
    TidyDoc tidyCreateWithAllocator(TidyAllocator *allocator)
    void tidyRelease(TidyDoc tdoc)
    int tidyStatus(TidyDoc tdoc)
    int tidyDetectedHtmlVersion(TidyDoc tdoc)
    Bool tidyDetectedXhtml(TidyDoc tdoc)
    Bool tidyDetectedGenericXml(TidyDoc tdoc)
    uint tidyErrorCount(TidyDoc tdoc)
    uint tidyWarningCount(TidyDoc tdoc)
    int tidyCleanAndRepair(TidyDoc tdoc)
    int tidyRunDiagnostics(TidyDoc tdoc)
    int tidyReportDoctype(TidyDoc tdoc)
    void tidySetAppData(TidyDoc tdoc, void *appData)
    void *tidyGetAppData(TidyDoc tdoc)
    void tidyErrorSummary(TidyDoc tdoc)
    void tidyGeneralInfo(TidyDoc tdoc)
    TidyIterator tidyOptGetPriorityAttrList(TidyDoc tdoc)
    ctmbstr tidyOptGetNextPriorityAttr(TidyDoc tdoc, TidyIterator *iter)
    TidyIterator tidyOptGetMutedMessageList(TidyDoc tdoc)
    ctmbstr tidyOptGetNextMutedMessage(TidyDoc tdoc, TidyIterator* iter)
    int tidySaveBuffer(TidyDoc tdoc, TidyBuffer *buf)
    int tidyOptSaveFile(TidyDoc tdoc, ctmbstr cfgfil)
    int tidySaveSink(TidyDoc tdoc, TidyOutputSink *sink)
    int tidySetErrorBuffer(TidyDoc tdoc,  TidyBuffer *errbuf)
    int tidySetErrorSink(TidyDoc tdoc, TidyOutputSink *sink)
    int tidyParseSource(TidyDoc tdoc, TidyInputSource *source)
    int tidySaveFile(TidyDoc tdoc, ctmbstr filename)
    int tidySaveStdout(TidyDoc tdoc)
    int tidySetInCharEncoding(TidyDoc tdoc, ctmbstr encnam)
    Bool tidySetMessageCallback(TidyDoc tdoc, TidyMessageCallback filtCallback)
    int tidyLoadConfig(TidyDoc tdoc, ctmbstr configFile)
    int tidyLoadConfigEnc(TidyDoc tdoc, ctmbstr configFile, ctmbstr charenc)
    int tidySetOutCharEncoding(TidyDoc tdoc, ctmbstr encnam)
    int tidyParseString(TidyDoc tdoc, ctmbstr content)
    int tidyParseBuffer(TidyDoc tdoc, TidyBuffer *buf)
    int tidyParseFile(TidyDoc tdoc, ctmbstr filename)
    int tidyOptSaveSink(TidyDoc tdoc, TidyOutputSink *sink)

    # Node

    TidyNode tidyGetParent(TidyNode tnod)
    TidyNode tidyGetChild(TidyNode tnod)
    TidyNode tidyGetNext(TidyNode tnod)
    TidyNode tidyGetPrev(TidyNode tnod)
    TidyNode tidyDiscardElement(TidyDoc tdoc, TidyNode tnod)
    TidyNodeType tidyNodeGetType(TidyNode tnod)
    ctmbstr tidyNodeGetName(TidyNode tnod)
    Bool tidyNodeIsText(TidyNode tnod)
    TidyTagId tidyNodeGetId(TidyNode tnod)
    uint tidyNodeLine(TidyNode tnod)
    uint tidyNodeColumn(TidyNode tnod)
    TidyAttr tidyAttrGetById(TidyNode tnod, TidyAttrId attId)

    # Attribute

    TidyAttr tidyAttrFirst(TidyNode tnod)
    TidyAttr tidyAttrNext(TidyAttr tattr)
    ctmbstr tidyAttrName(TidyAttr tattr)
    ctmbstr tidyAttrValue(TidyAttr tattr)
    void tidyAttrDiscard(TidyDoc itdoc, TidyNode tnod, TidyAttr tattr)
    TidyAttrId tidyAttrGetId(TidyAttr tattr)
    Bool tidyAttrIsEvent(TidyAttr tattr)

    # Options

    TidyOptionId tidyOptGetId(TidyOption opt)
    TidyOptionId tidyOptGetIdForName(ctmbstr optnam)
    TidyIterator tidyGetOptionList(TidyDoc tdoc)
    TidyOption tidyGetNextOption(TidyDoc tdoc, TidyIterator *pos)
    TidyOption tidyGetOption(TidyDoc tdoc, TidyOptionId optId)
    TidyOption tidyGetOptionByName(TidyDoc tdoc, ctmbstr optnam)
    ctmbstr tidyOptGetName(TidyOption opt)
    TidyOptionType tidyOptGetType(TidyOption opt)
    Bool tidyOptionIsList(TidyOption opt)
    Bool tidyOptIsReadOnly(TidyOption opt)
    TidyConfigCategory tidyOptGetCategory(TidyOption opt)
    ctmbstr tidyOptGetDefault(TidyOption opt)
    ulong tidyOptGetDefaultInt(TidyOption opt)
    Bool tidyOptGetDefaultBool(TidyOption opt)
    TidyIterator tidyOptGetPickList(TidyOption opt)
    ctmbstr tidyOptGetNextPick(TidyOption opt, TidyIterator *pos)
    TidyIterator tidyOptGetDocLinksList(TidyDoc tdoc, TidyOption opt)
    TidyOption tidyOptGetNextDocLinks(TidyDoc tdoc, TidyIterator *pos)

    # Option Value Functions

    ctmbstr tidyOptGetValue(TidyDoc tdoc, TidyOptionId optId)
    Bool tidyOptSetValue(TidyDoc tdoc, TidyOptionId optId, ctmbstr val)
    Bool tidyOptParseValue(TidyDoc tdoc, ctmbstr optnam, ctmbstr val)
    ulong tidyOptGetInt(TidyDoc tdoc, TidyOptionId optId)
    Bool tidyOptSetInt(TidyDoc tdoc, TidyOptionId optId, ulong val)
    Bool tidyOptGetBool(TidyDoc tdoc, TidyOptionId optId)
    Bool tidyOptSetBool(TidyDoc tdoc, TidyOptionId optId, Bool val)
    Bool tidyOptResetToDefault(TidyDoc tdoc, TidyOptionId opt)
    Bool tidyOptResetAllToDefault(TidyDoc tdoc)
    Bool tidyOptSnapshot(TidyDoc tdoc)
    Bool tidyOptResetToSnapshot(TidyDoc tdoc)
    Bool tidyOptDiffThanDefault(TidyDoc tdoc)
    Bool tidyOptDiffThanSnapshot(TidyDoc tdoc)
    Bool tidyOptCopyConfig(TidyDoc tdocTo, TidyDoc tdocFrom)
    ctmbstr tidyOptGetEncName(TidyDoc tdoc, TidyOptionId optId)
    ctmbstr tidyOptGetCurrPick(TidyDoc tdoc, TidyOptionId optId)
    TidyIterator tidyOptGetDeclTagList(TidyDoc tdoc)
    ctmbstr tidyOptGetNextDeclTag(TidyDoc tdoc, TidyOptionId optId, TidyIterator *iter)
    TidyIterator tidyOptGetPriorityAttrList(TidyDoc tdoc)
    ctmbstr tidyOptGetNextPriorityAttr(TidyDoc tdoc, TidyIterator *iter)
    TidyIterator tidyOptGetMutedMessageList(TidyDoc tdoc)
    ctmbstr tidyOptGetNextMutedMessage(TidyDoc tdoc, TidyIterator *iter)
    ctmbstr tidyOptGetDoc(TidyDoc tdoc, TidyOption opt)
    TidyIterator tidyOptGetDocLinksList(TidyDoc tdoc, TidyOption opt)
    TidyOption tidyOptGetNextDocLinks(TidyDoc tdoc, TidyIterator *pos)

    # Message

    TidyDoc tidyGetMessageDoc(TidyMessage tmessage)
    uint tidyGetMessageCode(TidyMessage tmessage)
    ctmbstr tidyGetMessageKey(TidyMessage tmessage)
    int tidyGetMessageLine(TidyMessage tmessage)
    int tidyGetMessageColumn(TidyMessage tmessage)
    TidyReportLevel tidyGetMessageLevel(TidyMessage tmessage)
    Bool tidyGetMessageIsMuted(TidyMessage tmessage)
    ctmbstr tidyGetMessageFormatDefault(TidyMessage tmessage)
    ctmbstr tidyGetMessageFormat(TidyMessage tmessage)
    ctmbstr tidyGetMessageDefault(TidyMessage tmessage)
    ctmbstr tidyGetMessage(TidyMessage tmessage)
    ctmbstr tidyGetMessagePosDefault(TidyMessage tmessage)
    ctmbstr tidyGetMessagePos(TidyMessage tmessage)
    ctmbstr tidyGetMessagePrefixDefault(TidyMessage tmessage)
    ctmbstr tidyGetMessagePrefix(TidyMessage tmessage)
    ctmbstr tidyGetMessageOutputDefault(TidyMessage tmessage)
    ctmbstr tidyGetMessageOutput(TidyMessage tmessage)
    TidyIterator tidyGetMessageArguments(TidyMessage tmessage)
    TidyMessageArgument tidyGetNextMessageArgument(TidyMessage tmessage, TidyIterator *iter)
    TidyFormatParameterType tidyGetArgType(TidyMessage tmessage, TidyMessageArgument *arg)
    ctmbstr tidyGetArgFormat(TidyMessage tmessage, TidyMessageArgument *arg)
    ctmbstr tidyGetArgValueString(TidyMessage tmessage, TidyMessageArgument *arg)
    uint tidyGetArgValueUInt(TidyMessage tmessage, TidyMessageArgument *arg)
    int tidyGetArgValueInt(TidyMessage tmessage, TidyMessageArgument *arg)
    double tidyGetArgValueDouble(TidyMessage tmessage, TidyMessageArgument *arg)

    # Input source

    uint tidyGetByte(TidyInputSource *source)
    void tidyUngetByte(TidyInputSource *source, uint byteValue)
    Bool tidyIsEOF(TidyInputSource *source)


cdef extern from 'tidybuffio.h' nogil:
    ctypedef struct TidyBuffer:
        TidyAllocator *allocator
        byte *bp
        uint size
        uint allocated
        uint next

    void tidyBufInitWithAllocator(TidyBuffer *buf, TidyAllocator *allocator)
    void tidyBufCheckAlloc(TidyBuffer *buf, uint allocSize, uint chunkSize)

    void tidyBufFree(TidyBuffer *buf)
    void tidyBufAppend(TidyBuffer *buf, void *vp, uint size)
    void tidyBufPutByte(TidyBuffer *buf, byte bv)
    int tidyBufPopByte(TidyBuffer *buf)
    int tidyBufGetByte(TidyBuffer *buf)
    Bool tidyBufEndOfInput(TidyBuffer *buf)
    void tidyBufUngetByte(TidyBuffer *buf, byte bv)
    void tidyInitOutputBuffer(TidyOutputSink *outp, TidyBuffer *buf)
    void tidyBufAttach(TidyBuffer *buf, byte *bp, uint size)
    void tidyBufDetach(TidyBuffer *buf)
