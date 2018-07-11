cdef type _OptionId
cdef type _ConfigCategory
cdef type _OptionType
cdef type _TriState
cdef type _UseCustomTagsState
cdef type _LineEnding
cdef type _EncodingOptions
cdef type _DoctypeModes
cdef type _DupAttrModes
cdef type _AttrSortStrategy
cdef type _Uppercase
cdef type _NodeType
cdef type _TagId
cdef type _AttrId
cdef type _ReportLevel
cdef type _FormatParameterType
cdef type _Strings
cdef type _ParseOutcome


class _OptionId(IntEnum):
    __name__ =  __qualname__ = 'OptionId'

    for_name = staticmethod(option_id_for_name)

    UnknownOption = <int> TidyUnknownOption
    AccessibilityCheckLevel = <int> TidyAccessibilityCheckLevel
    AltText = <int> TidyAltText
    AnchorAsName = <int> TidyAnchorAsName
    AsciiChars = <int> TidyAsciiChars
    BlockTags = <int> TidyBlockTags
    BodyOnly = <int> TidyBodyOnly
    BreakBeforeBR = <int> TidyBreakBeforeBR
    CharEncoding = <int> TidyCharEncoding
    CoerceEndTags = <int> TidyCoerceEndTags
    CSSPrefix = <int> TidyCSSPrefix
    DecorateInferredUL = <int> TidyDecorateInferredUL
    Doctype = <int> TidyDoctype
    DropEmptyElems = <int> TidyDropEmptyElems
    DropEmptyParas = <int> TidyDropEmptyParas
    DropPropAttrs = <int> TidyDropPropAttrs
    DuplicateAttrs = <int> TidyDuplicateAttrs
    Emacs = <int> TidyEmacs
    EmptyTags = <int> TidyEmptyTags
    EncloseBlockText = <int> TidyEncloseBlockText
    EncloseBodyText = <int> TidyEncloseBodyText
    ErrFile = <int> TidyErrFile
    EscapeCdata = <int> TidyEscapeCdata
    EscapeScripts = <int> TidyEscapeScripts
    FixBackslash = <int> TidyFixBackslash
    FixComments = <int> TidyFixComments
    FixUri = <int> TidyFixUri
    ForceOutput = <int> TidyForceOutput
    GDocClean = <int> TidyGDocClean
    HideComments = <int> TidyHideComments
    HtmlOut = <int> TidyHtmlOut
    InCharEncoding = <int> TidyInCharEncoding
    IndentAttributes = <int> TidyIndentAttributes
    IndentCdata = <int> TidyIndentCdata
    IndentContent = <int> TidyIndentContent
    IndentSpaces = <int> TidyIndentSpaces
    InlineTags = <int> TidyInlineTags
    JoinClasses = <int> TidyJoinClasses
    JoinStyles = <int> TidyJoinStyles
    KeepFileTimes = <int> TidyKeepFileTimes
    KeepTabs = <int> TidyKeepTabs
    LiteralAttribs = <int> TidyLiteralAttribs
    LogicalEmphasis = <int> TidyLogicalEmphasis
    LowerLiterals = <int> TidyLowerLiterals
    MakeBare = <int> TidyMakeBare
    MakeClean = <int> TidyMakeClean
    Mark = <int> TidyMark
    MergeDivs = <int> TidyMergeDivs
    MergeEmphasis = <int> TidyMergeEmphasis
    MergeSpans = <int> TidyMergeSpans
    MetaCharset = <int> TidyMetaCharset
    MuteReports = <int> TidyMuteReports
    MuteShow = <int> TidyMuteShow
    NCR = <int> TidyNCR
    Newline = <int> TidyNewline
    NumEntities = <int> TidyNumEntities
    OmitOptionalTags = <int> TidyOmitOptionalTags
    OutCharEncoding = <int> TidyOutCharEncoding
    OutFile = <int> TidyOutFile
    OutputBOM = <int> TidyOutputBOM
    PPrintTabs = <int> TidyPPrintTabs
    PreserveEntities = <int> TidyPreserveEntities
    PreTags = <int> TidyPreTags
    PriorityAttributes = <int> TidyPriorityAttributes
    PunctWrap = <int> TidyPunctWrap
    Quiet = <int> TidyQuiet
    QuoteAmpersand = <int> TidyQuoteAmpersand
    QuoteMarks = <int> TidyQuoteMarks
    QuoteNbsp = <int> TidyQuoteNbsp
    ReplaceColor = <int> TidyReplaceColor
    ShowErrors = <int> TidyShowErrors
    ShowInfo = <int> TidyShowInfo
    ShowMarkup = <int> TidyShowMarkup
    ShowMetaChange = <int> TidyShowMetaChange
    ShowWarnings = <int> TidyShowWarnings
    SkipNested = <int> TidySkipNested
    SortAttributes = <int> TidySortAttributes
    StrictTagsAttr = <int> TidyStrictTagsAttr
    StyleTags = <int> TidyStyleTags
    TabSize = <int> TidyTabSize
    UpperCaseAttrs = <int> TidyUpperCaseAttrs
    UpperCaseTags = <int> TidyUpperCaseTags
    UseCustomTags = <int> TidyUseCustomTags
    VertSpace = <int> TidyVertSpace
    WarnPropAttrs = <int> TidyWarnPropAttrs
    Word2000 = <int> TidyWord2000
    WrapAsp = <int> TidyWrapAsp
    WrapAttVals = <int> TidyWrapAttVals
    WrapJste = <int> TidyWrapJste
    WrapLen = <int> TidyWrapLen
    WrapPhp = <int> TidyWrapPhp
    WrapScriptlets = <int> TidyWrapScriptlets
    WrapSection = <int> TidyWrapSection
    WriteBack = <int> TidyWriteBack
    XhtmlOut = <int> TidyXhtmlOut
    XmlDecl = <int> TidyXmlDecl
    XmlOut = <int> TidyXmlOut
    XmlPIs = <int> TidyXmlPIs
    XmlSpace = <int> TidyXmlSpace
    XmlTags = <int> TidyXmlTags
    _N = <int> N_TIDY_OPTIONS


class _ConfigCategory(IntEnum):
    __name__ = __qualname__ = 'ConfigCategory'

    for_name = staticmethod(config_category_for_name)

    Diagnostics = <int> TidyDiagnostics
    Display = <int> TidyDisplay
    DocumentIO = <int> TidyDocumentIO
    Encoding = <int> TidyEncoding
    FileIO = <int> TidyFileIO
    MarkupCleanup = <int> TidyMarkupCleanup
    MarkupEntities = <int> TidyMarkupEntities
    MarkupRepair = <int> TidyMarkupRepair
    MarkupTeach = <int> TidyMarkupTeach
    MarkupXForm = <int> TidyMarkupXForm
    PrettyPrint = <int> TidyPrettyPrint
    InternalCategory = <int> TidyInternalCategory


class _OptionType(IntEnum):
    __name__ = __qualname__ = 'OptionType'

    for_name = staticmethod(option_type_for_name)

    String = <int> TidyString
    Integer = <int> TidyInteger
    Boolean = <int> TidyBoolean


class _TriState(IntEnum):
    __name__ = __qualname__ = 'TriState'

    for_name = staticmethod(tristate_for_name)

    No = <int> TidyNoState
    Yes = <int> TidyYesState
    Auto = <int> TidyAutoState


class _UseCustomTagsState(IntEnum):
    __name__ = __qualname__ = 'UseCustomTagsState'

    for_name = staticmethod(use_custom_tags_state_for_name)

    No = <int> TidyCustomNo
    Blocklevel = <int> TidyCustomBlocklevel
    Empty = <int> TidyCustomEmpty
    Inline = <int> TidyCustomInline
    Pre = <int> TidyCustomPre


class _LineEnding(IntEnum):
    __name__ = __qualname__ = 'LineEnding'

    for_name = staticmethod(line_endings_for_name)

    LF = <int> TidyLF
    CRLF = <int> TidyCRLF
    CR = <int> TidyCR


class _EncodingOptions(IntEnum):
    __name__ = __qualname__ = 'EncodingOptions'

    for_name = staticmethod(encoding_options_for_name)

    Raw = <int> TidyEncRaw
    Ascii = <int> TidyEncAscii
    Latin0 = <int> TidyEncLatin0
    Latin1 = <int> TidyEncLatin1
    Utf8 = <int> TidyEncUtf8
    Mac = <int> TidyEncMac
    Win1252 = <int> TidyEncWin1252
    Ibm858 = <int> TidyEncIbm858
    Utf16le = <int> TidyEncUtf16le
    Utf16be = <int> TidyEncUtf16be
    Utf16 = <int> TidyEncUtf16
    Big5 = <int> TidyEncBig5


class _DoctypeModes(IntEnum):
    __name__ = __qualname__ = 'DoctypeModes'

    for_name = staticmethod(doctype_modes_for_name)

    Html5 = <int> TidyDoctypeHtml5
    Omit = <int> TidyDoctypeOmit
    Auto = <int> TidyDoctypeAuto
    Strict = <int> TidyDoctypeStrict
    Loose = <int> TidyDoctypeLoose
    User = <int> TidyDoctypeUser


class _DupAttrModes(IntEnum):
    __name__ = __qualname__ = 'DupAttrModes'

    for_name = staticmethod(dup_attr_modes_for_name)

    KeepFirst = <int> TidyKeepFirst
    KeepLast = <int> TidyKeepLast


class _AttrSortStrategy(IntEnum):
    __name__ = __qualname__ = 'AttrSortStrategy'

    for_name = staticmethod(attr_sort_strategy_for_name)

    None_ = <int> TidySortAttrNone
    Alpha = <int> TidySortAttrAlpha


class _Uppercase(IntEnum):
    __name__ = __qualname__ = 'Uppercase'

    for_name = staticmethod(uppercase_for_name)

    No = <int> TidyUppercaseNo
    Yes = <int> TidyUppercaseYes
    Preserve = <int> TidyUppercasePreserve


class _NodeType(IntEnum):
    __name__ = __qualname__ = 'NodeType'

    for_name = staticmethod(node_type_for_name)

    Root = <int> TidyNode_Root
    DocType = <int> TidyNode_DocType
    Comment = <int> TidyNode_Comment
    ProcIns = <int> TidyNode_ProcIns
    Text = <int> TidyNode_Text
    Start = <int> TidyNode_Start
    End = <int> TidyNode_End
    StartEnd = <int> TidyNode_StartEnd
    CDATA = <int> TidyNode_CDATA
    Section = <int> TidyNode_Section
    Asp = <int> TidyNode_Asp
    Jste = <int> TidyNode_Jste
    Php = <int> TidyNode_Php
    XmlDecl = <int> TidyNode_XmlDecl


class _TagId(IntEnum):
    __name__ = __qualname__ = 'TagId'

    for_name = staticmethod(tag_id_for_name)

    UNKNOWN = <int> TidyTag_UNKNOWN
    A = <int> TidyTag_A
    ABBR = <int> TidyTag_ABBR
    ACRONYM = <int> TidyTag_ACRONYM
    ADDRESS = <int> TidyTag_ADDRESS
    ALIGN = <int> TidyTag_ALIGN
    APPLET = <int> TidyTag_APPLET
    AREA = <int> TidyTag_AREA
    B = <int> TidyTag_B
    BASE = <int> TidyTag_BASE
    BASEFONT = <int> TidyTag_BASEFONT
    BDO = <int> TidyTag_BDO
    BGSOUND = <int> TidyTag_BGSOUND
    BIG = <int> TidyTag_BIG
    BLINK = <int> TidyTag_BLINK
    BLOCKQUOTE = <int> TidyTag_BLOCKQUOTE
    BODY = <int> TidyTag_BODY
    BR = <int> TidyTag_BR
    BUTTON = <int> TidyTag_BUTTON
    CAPTION = <int> TidyTag_CAPTION
    CENTER = <int> TidyTag_CENTER
    CITE = <int> TidyTag_CITE
    CODE = <int> TidyTag_CODE
    COL = <int> TidyTag_COL
    COLGROUP = <int> TidyTag_COLGROUP
    COMMENT = <int> TidyTag_COMMENT
    DD = <int> TidyTag_DD
    DEL = <int> TidyTag_DEL
    DFN = <int> TidyTag_DFN
    DIR = <int> TidyTag_DIR
    DIV = <int> TidyTag_DIV
    DL = <int> TidyTag_DL
    DT = <int> TidyTag_DT
    EM = <int> TidyTag_EM
    EMBED = <int> TidyTag_EMBED
    FIELDSET = <int> TidyTag_FIELDSET
    FONT = <int> TidyTag_FONT
    FORM = <int> TidyTag_FORM
    FRAME = <int> TidyTag_FRAME
    FRAMESET = <int> TidyTag_FRAMESET
    H1 = <int> TidyTag_H1
    H2 = <int> TidyTag_H2
    H3 = <int> TidyTag_H3
    H4 = <int> TidyTag_H4
    H5 = <int> TidyTag_H5
    H6 = <int> TidyTag_H6
    HEAD = <int> TidyTag_HEAD
    HR = <int> TidyTag_HR
    HTML = <int> TidyTag_HTML
    I = <int> TidyTag_I
    IFRAME = <int> TidyTag_IFRAME
    ILAYER = <int> TidyTag_ILAYER
    IMG = <int> TidyTag_IMG
    INPUT = <int> TidyTag_INPUT
    INS = <int> TidyTag_INS
    ISINDEX = <int> TidyTag_ISINDEX
    KBD = <int> TidyTag_KBD
    KEYGEN = <int> TidyTag_KEYGEN
    LABEL = <int> TidyTag_LABEL
    LAYER = <int> TidyTag_LAYER
    LEGEND = <int> TidyTag_LEGEND
    LI = <int> TidyTag_LI
    LINK = <int> TidyTag_LINK
    LISTING = <int> TidyTag_LISTING
    MAP = <int> TidyTag_MAP
    MATHML = <int> TidyTag_MATHML
    MARQUEE = <int> TidyTag_MARQUEE
    MENU = <int> TidyTag_MENU
    META = <int> TidyTag_META
    MULTICOL = <int> TidyTag_MULTICOL
    NOBR = <int> TidyTag_NOBR
    NOEMBED = <int> TidyTag_NOEMBED
    NOFRAMES = <int> TidyTag_NOFRAMES
    NOLAYER = <int> TidyTag_NOLAYER
    NOSAVE = <int> TidyTag_NOSAVE
    NOSCRIPT = <int> TidyTag_NOSCRIPT
    OBJECT = <int> TidyTag_OBJECT
    OL = <int> TidyTag_OL
    OPTGROUP = <int> TidyTag_OPTGROUP
    OPTION = <int> TidyTag_OPTION
    P = <int> TidyTag_P
    PARAM = <int> TidyTag_PARAM
    PICTURE = <int> TidyTag_PICTURE
    PLAINTEXT = <int> TidyTag_PLAINTEXT
    PRE = <int> TidyTag_PRE
    Q = <int> TidyTag_Q
    RB = <int> TidyTag_RB
    RBC = <int> TidyTag_RBC
    RP = <int> TidyTag_RP
    RT = <int> TidyTag_RT
    RTC = <int> TidyTag_RTC
    RUBY = <int> TidyTag_RUBY
    S = <int> TidyTag_S
    SAMP = <int> TidyTag_SAMP
    SCRIPT = <int> TidyTag_SCRIPT
    SELECT = <int> TidyTag_SELECT
    SERVER = <int> TidyTag_SERVER
    SERVLET = <int> TidyTag_SERVLET
    SMALL = <int> TidyTag_SMALL
    SPACER = <int> TidyTag_SPACER
    SPAN = <int> TidyTag_SPAN
    STRIKE = <int> TidyTag_STRIKE
    STRONG = <int> TidyTag_STRONG
    STYLE = <int> TidyTag_STYLE
    SUB = <int> TidyTag_SUB
    SUP = <int> TidyTag_SUP
    SVG = <int> TidyTag_SVG
    TABLE = <int> TidyTag_TABLE
    TBODY = <int> TidyTag_TBODY
    TD = <int> TidyTag_TD
    TEXTAREA = <int> TidyTag_TEXTAREA
    TFOOT = <int> TidyTag_TFOOT
    TH = <int> TidyTag_TH
    THEAD = <int> TidyTag_THEAD
    TITLE = <int> TidyTag_TITLE
    TR = <int> TidyTag_TR
    TT = <int> TidyTag_TT
    U = <int> TidyTag_U
    UL = <int> TidyTag_UL
    VAR = <int> TidyTag_VAR
    WBR = <int> TidyTag_WBR
    XMP = <int> TidyTag_XMP
    NEXTID = <int> TidyTag_NEXTID
    ARTICLE = <int> TidyTag_ARTICLE
    ASIDE = <int> TidyTag_ASIDE
    AUDIO = <int> TidyTag_AUDIO
    BDI = <int> TidyTag_BDI
    CANVAS = <int> TidyTag_CANVAS
    COMMAND = <int> TidyTag_COMMAND
    DATALIST = <int> TidyTag_DATALIST
    DETAILS = <int> TidyTag_DETAILS
    DIALOG = <int> TidyTag_DIALOG
    FIGCAPTION = <int> TidyTag_FIGCAPTION
    FIGURE = <int> TidyTag_FIGURE
    FOOTER = <int> TidyTag_FOOTER
    HEADER = <int> TidyTag_HEADER
    HGROUP = <int> TidyTag_HGROUP
    MAIN = <int> TidyTag_MAIN
    MARK = <int> TidyTag_MARK
    MENUITEM = <int> TidyTag_MENUITEM
    METER = <int> TidyTag_METER
    NAV = <int> TidyTag_NAV
    OUTPUT = <int> TidyTag_OUTPUT
    PROGRESS = <int> TidyTag_PROGRESS
    SECTION = <int> TidyTag_SECTION
    SOURCE = <int> TidyTag_SOURCE
    SUMMARY = <int> TidyTag_SUMMARY
    TEMPLATE = <int> TidyTag_TEMPLATE
    TIME = <int> TidyTag_TIME
    TRACK = <int> TidyTag_TRACK
    VIDEO = <int> TidyTag_VIDEO
    _N = <int> N_TIDY_TAGS


class _AttrId(IntEnum):
    __name__ = __qualname__ = 'AttrId'

    for_name = staticmethod(attr_id_for_name)

    UNKNOWN = <int> TidyAttr_UNKNOWN
    ABBR = <int> TidyAttr_ABBR
    ACCEPT = <int> TidyAttr_ACCEPT
    ACCEPT_CHARSET = <int> TidyAttr_ACCEPT_CHARSET
    ACCESSKEY = <int> TidyAttr_ACCESSKEY
    ACTION = <int> TidyAttr_ACTION
    ADD_DATE = <int> TidyAttr_ADD_DATE
    ALIGN = <int> TidyAttr_ALIGN
    ALINK = <int> TidyAttr_ALINK
    ALLOWFULLSCREEN = <int> TidyAttr_ALLOWFULLSCREEN
    ALT = <int> TidyAttr_ALT
    ARCHIVE = <int> TidyAttr_ARCHIVE
    AXIS = <int> TidyAttr_AXIS
    BACKGROUND = <int> TidyAttr_BACKGROUND
    BGCOLOR = <int> TidyAttr_BGCOLOR
    BGPROPERTIES = <int> TidyAttr_BGPROPERTIES
    BORDER = <int> TidyAttr_BORDER
    BORDERCOLOR = <int> TidyAttr_BORDERCOLOR
    BOTTOMMARGIN = <int> TidyAttr_BOTTOMMARGIN
    CELLPADDING = <int> TidyAttr_CELLPADDING
    CELLSPACING = <int> TidyAttr_CELLSPACING
    CHAR = <int> TidyAttr_CHAR
    CHAROFF = <int> TidyAttr_CHAROFF
    CHARSET = <int> TidyAttr_CHARSET
    CHECKED = <int> TidyAttr_CHECKED
    CITE = <int> TidyAttr_CITE
    CLASS = <int> TidyAttr_CLASS
    CLASSID = <int> TidyAttr_CLASSID
    CLEAR = <int> TidyAttr_CLEAR
    CODE = <int> TidyAttr_CODE
    CODEBASE = <int> TidyAttr_CODEBASE
    CODETYPE = <int> TidyAttr_CODETYPE
    COLOR = <int> TidyAttr_COLOR
    COLS = <int> TidyAttr_COLS
    COLSPAN = <int> TidyAttr_COLSPAN
    COMPACT = <int> TidyAttr_COMPACT
    CONTENT = <int> TidyAttr_CONTENT
    COORDS = <int> TidyAttr_COORDS
    DATA = <int> TidyAttr_DATA
    DATAFLD = <int> TidyAttr_DATAFLD
    DATAFORMATAS = <int> TidyAttr_DATAFORMATAS
    DATAPAGESIZE = <int> TidyAttr_DATAPAGESIZE
    DATASRC = <int> TidyAttr_DATASRC
    DATETIME = <int> TidyAttr_DATETIME
    DECLARE = <int> TidyAttr_DECLARE
    DEFER = <int> TidyAttr_DEFER
    DIR = <int> TidyAttr_DIR
    DISABLED = <int> TidyAttr_DISABLED
    DOWNLOAD = <int> TidyAttr_DOWNLOAD
    ENCODING = <int> TidyAttr_ENCODING
    ENCTYPE = <int> TidyAttr_ENCTYPE
    FACE = <int> TidyAttr_FACE
    FOR = <int> TidyAttr_FOR
    FRAME = <int> TidyAttr_FRAME
    FRAMEBORDER = <int> TidyAttr_FRAMEBORDER
    FRAMESPACING = <int> TidyAttr_FRAMESPACING
    GRIDX = <int> TidyAttr_GRIDX
    GRIDY = <int> TidyAttr_GRIDY
    HEADERS = <int> TidyAttr_HEADERS
    HEIGHT = <int> TidyAttr_HEIGHT
    HREF = <int> TidyAttr_HREF
    HREFLANG = <int> TidyAttr_HREFLANG
    HSPACE = <int> TidyAttr_HSPACE
    HTTP_EQUIV = <int> TidyAttr_HTTP_EQUIV
    ID = <int> TidyAttr_ID
    IS = <int> TidyAttr_IS
    ISMAP = <int> TidyAttr_ISMAP
    ITEMID = <int> TidyAttr_ITEMID
    ITEMPROP = <int> TidyAttr_ITEMPROP
    ITEMREF = <int> TidyAttr_ITEMREF
    ITEMSCOPE = <int> TidyAttr_ITEMSCOPE
    ITEMTYPE = <int> TidyAttr_ITEMTYPE
    LABEL = <int> TidyAttr_LABEL
    LANG = <int> TidyAttr_LANG
    LANGUAGE = <int> TidyAttr_LANGUAGE
    LAST_MODIFIED = <int> TidyAttr_LAST_MODIFIED
    LAST_VISIT = <int> TidyAttr_LAST_VISIT
    LEFTMARGIN = <int> TidyAttr_LEFTMARGIN
    LINK = <int> TidyAttr_LINK
    LONGDESC = <int> TidyAttr_LONGDESC
    LOWSRC = <int> TidyAttr_LOWSRC
    MARGINHEIGHT = <int> TidyAttr_MARGINHEIGHT
    MARGINWIDTH = <int> TidyAttr_MARGINWIDTH
    MAXLENGTH = <int> TidyAttr_MAXLENGTH
    MEDIA = <int> TidyAttr_MEDIA
    METHOD = <int> TidyAttr_METHOD
    MULTIPLE = <int> TidyAttr_MULTIPLE
    NAME = <int> TidyAttr_NAME
    NOHREF = <int> TidyAttr_NOHREF
    NORESIZE = <int> TidyAttr_NORESIZE
    NOSHADE = <int> TidyAttr_NOSHADE
    NOWRAP = <int> TidyAttr_NOWRAP
    OBJECT = <int> TidyAttr_OBJECT
    OnAFTERUPDATE = <int> TidyAttr_OnAFTERUPDATE
    OnBEFOREUNLOAD = <int> TidyAttr_OnBEFOREUNLOAD
    OnBEFOREUPDATE = <int> TidyAttr_OnBEFOREUPDATE
    OnBLUR = <int> TidyAttr_OnBLUR
    OnCHANGE = <int> TidyAttr_OnCHANGE
    OnCLICK = <int> TidyAttr_OnCLICK
    OnDATAAVAILABLE = <int> TidyAttr_OnDATAAVAILABLE
    OnDATASETCHANGED = <int> TidyAttr_OnDATASETCHANGED
    OnDATASETCOMPLETE = <int> TidyAttr_OnDATASETCOMPLETE
    OnDBLCLICK = <int> TidyAttr_OnDBLCLICK
    OnERRORUPDATE = <int> TidyAttr_OnERRORUPDATE
    OnFOCUS = <int> TidyAttr_OnFOCUS
    OnKEYDOWN = <int> TidyAttr_OnKEYDOWN
    OnKEYPRESS = <int> TidyAttr_OnKEYPRESS
    OnKEYUP = <int> TidyAttr_OnKEYUP
    OnLOAD = <int> TidyAttr_OnLOAD
    OnMOUSEDOWN = <int> TidyAttr_OnMOUSEDOWN
    OnMOUSEMOVE = <int> TidyAttr_OnMOUSEMOVE
    OnMOUSEOUT = <int> TidyAttr_OnMOUSEOUT
    OnMOUSEOVER = <int> TidyAttr_OnMOUSEOVER
    OnMOUSEUP = <int> TidyAttr_OnMOUSEUP
    OnRESET = <int> TidyAttr_OnRESET
    OnROWENTER = <int> TidyAttr_OnROWENTER
    OnROWEXIT = <int> TidyAttr_OnROWEXIT
    OnSELECT = <int> TidyAttr_OnSELECT
    OnSUBMIT = <int> TidyAttr_OnSUBMIT
    OnUNLOAD = <int> TidyAttr_OnUNLOAD
    PROFILE = <int> TidyAttr_PROFILE
    PROMPT = <int> TidyAttr_PROMPT
    RBSPAN = <int> TidyAttr_RBSPAN
    READONLY = <int> TidyAttr_READONLY
    REL = <int> TidyAttr_REL
    REV = <int> TidyAttr_REV
    RIGHTMARGIN = <int> TidyAttr_RIGHTMARGIN
    ROLE = <int> TidyAttr_ROLE
    ROWS = <int> TidyAttr_ROWS
    ROWSPAN = <int> TidyAttr_ROWSPAN
    RULES = <int> TidyAttr_RULES
    SCHEME = <int> TidyAttr_SCHEME
    SCOPE = <int> TidyAttr_SCOPE
    SCROLLING = <int> TidyAttr_SCROLLING
    SELECTED = <int> TidyAttr_SELECTED
    SHAPE = <int> TidyAttr_SHAPE
    SHOWGRID = <int> TidyAttr_SHOWGRID
    SHOWGRIDX = <int> TidyAttr_SHOWGRIDX
    SHOWGRIDY = <int> TidyAttr_SHOWGRIDY
    SIZE = <int> TidyAttr_SIZE
    SPAN = <int> TidyAttr_SPAN
    SRC = <int> TidyAttr_SRC
    SRCSET = <int> TidyAttr_SRCSET
    STANDBY = <int> TidyAttr_STANDBY
    START = <int> TidyAttr_START
    STYLE = <int> TidyAttr_STYLE
    SUMMARY = <int> TidyAttr_SUMMARY
    TABINDEX = <int> TidyAttr_TABINDEX
    TARGET = <int> TidyAttr_TARGET
    TEXT = <int> TidyAttr_TEXT
    TITLE = <int> TidyAttr_TITLE
    TOPMARGIN = <int> TidyAttr_TOPMARGIN
    TRANSLATE = <int> TidyAttr_TRANSLATE
    TYPE = <int> TidyAttr_TYPE
    USEMAP = <int> TidyAttr_USEMAP
    VALIGN = <int> TidyAttr_VALIGN
    VALUE = <int> TidyAttr_VALUE
    VALUETYPE = <int> TidyAttr_VALUETYPE
    VERSION = <int> TidyAttr_VERSION
    VLINK = <int> TidyAttr_VLINK
    VSPACE = <int> TidyAttr_VSPACE
    WIDTH = <int> TidyAttr_WIDTH
    WRAP = <int> TidyAttr_WRAP
    XML_LANG = <int> TidyAttr_XML_LANG
    XML_SPACE = <int> TidyAttr_XML_SPACE
    XMLNS = <int> TidyAttr_XMLNS
    EVENT = <int> TidyAttr_EVENT
    METHODS = <int> TidyAttr_METHODS
    N = <int> TidyAttr_N
    SDAFORM = <int> TidyAttr_SDAFORM
    SDAPREF = <int> TidyAttr_SDAPREF
    SDASUFF = <int> TidyAttr_SDASUFF
    URN = <int> TidyAttr_URN
    ASYNC = <int> TidyAttr_ASYNC
    AUTOCOMPLETE = <int> TidyAttr_AUTOCOMPLETE
    AUTOFOCUS = <int> TidyAttr_AUTOFOCUS
    AUTOPLAY = <int> TidyAttr_AUTOPLAY
    CHALLENGE = <int> TidyAttr_CHALLENGE
    CONTENTEDITABLE = <int> TidyAttr_CONTENTEDITABLE
    CONTEXTMENU = <int> TidyAttr_CONTEXTMENU
    CONTROLS = <int> TidyAttr_CONTROLS
    CROSSORIGIN = <int> TidyAttr_CROSSORIGIN
    DEFAULT = <int> TidyAttr_DEFAULT
    DIRNAME = <int> TidyAttr_DIRNAME
    DRAGGABLE = <int> TidyAttr_DRAGGABLE
    DROPZONE = <int> TidyAttr_DROPZONE
    FORM = <int> TidyAttr_FORM
    FORMACTION = <int> TidyAttr_FORMACTION
    FORMENCTYPE = <int> TidyAttr_FORMENCTYPE
    FORMMETHOD = <int> TidyAttr_FORMMETHOD
    FORMNOVALIDATE = <int> TidyAttr_FORMNOVALIDATE
    FORMTARGET = <int> TidyAttr_FORMTARGET
    HIDDEN = <int> TidyAttr_HIDDEN
    HIGH = <int> TidyAttr_HIGH
    ICON = <int> TidyAttr_ICON
    KEYTYPE = <int> TidyAttr_KEYTYPE
    KIND = <int> TidyAttr_KIND
    LIST = <int> TidyAttr_LIST
    LOOP = <int> TidyAttr_LOOP
    LOW = <int> TidyAttr_LOW
    MANIFEST = <int> TidyAttr_MANIFEST
    MAX = <int> TidyAttr_MAX
    MEDIAGROUP = <int> TidyAttr_MEDIAGROUP
    MIN = <int> TidyAttr_MIN
    NOVALIDATE = <int> TidyAttr_NOVALIDATE
    OPEN = <int> TidyAttr_OPEN
    OPTIMUM = <int> TidyAttr_OPTIMUM
    OnABORT = <int> TidyAttr_OnABORT
    OnAFTERPRINT = <int> TidyAttr_OnAFTERPRINT
    OnBEFOREPRINT = <int> TidyAttr_OnBEFOREPRINT
    OnCANPLAY = <int> TidyAttr_OnCANPLAY
    OnCANPLAYTHROUGH = <int> TidyAttr_OnCANPLAYTHROUGH
    OnCONTEXTMENU = <int> TidyAttr_OnCONTEXTMENU
    OnCUECHANGE = <int> TidyAttr_OnCUECHANGE
    OnDRAG = <int> TidyAttr_OnDRAG
    OnDRAGEND = <int> TidyAttr_OnDRAGEND
    OnDRAGENTER = <int> TidyAttr_OnDRAGENTER
    OnDRAGLEAVE = <int> TidyAttr_OnDRAGLEAVE
    OnDRAGOVER = <int> TidyAttr_OnDRAGOVER
    OnDRAGSTART = <int> TidyAttr_OnDRAGSTART
    OnDROP = <int> TidyAttr_OnDROP
    OnDURATIONCHANGE = <int> TidyAttr_OnDURATIONCHANGE
    OnEMPTIED = <int> TidyAttr_OnEMPTIED
    OnENDED = <int> TidyAttr_OnENDED
    OnERROR = <int> TidyAttr_OnERROR
    OnHASHCHANGE = <int> TidyAttr_OnHASHCHANGE
    OnINPUT = <int> TidyAttr_OnINPUT
    OnINVALID = <int> TidyAttr_OnINVALID
    OnLOADEDDATA = <int> TidyAttr_OnLOADEDDATA
    OnLOADEDMETADATA = <int> TidyAttr_OnLOADEDMETADATA
    OnLOADSTART = <int> TidyAttr_OnLOADSTART
    OnMESSAGE = <int> TidyAttr_OnMESSAGE
    OnMOUSEWHEEL = <int> TidyAttr_OnMOUSEWHEEL
    OnOFFLINE = <int> TidyAttr_OnOFFLINE
    OnONLINE = <int> TidyAttr_OnONLINE
    OnPAGEHIDE = <int> TidyAttr_OnPAGEHIDE
    OnPAGESHOW = <int> TidyAttr_OnPAGESHOW
    OnPAUSE = <int> TidyAttr_OnPAUSE
    OnPLAY = <int> TidyAttr_OnPLAY
    OnPLAYING = <int> TidyAttr_OnPLAYING
    OnPOPSTATE = <int> TidyAttr_OnPOPSTATE
    OnPROGRESS = <int> TidyAttr_OnPROGRESS
    OnRATECHANGE = <int> TidyAttr_OnRATECHANGE
    OnREADYSTATECHANGE = <int> TidyAttr_OnREADYSTATECHANGE
    OnREDO = <int> TidyAttr_OnREDO
    OnRESIZE = <int> TidyAttr_OnRESIZE
    OnSCROLL = <int> TidyAttr_OnSCROLL
    OnSEEKED = <int> TidyAttr_OnSEEKED
    OnSEEKING = <int> TidyAttr_OnSEEKING
    OnSHOW = <int> TidyAttr_OnSHOW
    OnSTALLED = <int> TidyAttr_OnSTALLED
    OnSTORAGE = <int> TidyAttr_OnSTORAGE
    OnSUSPEND = <int> TidyAttr_OnSUSPEND
    OnTIMEUPDATE = <int> TidyAttr_OnTIMEUPDATE
    OnUNDO = <int> TidyAttr_OnUNDO
    OnVOLUMECHANGE = <int> TidyAttr_OnVOLUMECHANGE
    OnWAITING = <int> TidyAttr_OnWAITING
    PATTERN = <int> TidyAttr_PATTERN
    PLACEHOLDER = <int> TidyAttr_PLACEHOLDER
    POSTER = <int> TidyAttr_POSTER
    PRELOAD = <int> TidyAttr_PRELOAD
    PUBDATE = <int> TidyAttr_PUBDATE
    RADIOGROUP = <int> TidyAttr_RADIOGROUP
    REQUIRED = <int> TidyAttr_REQUIRED
    REVERSED = <int> TidyAttr_REVERSED
    SANDBOX = <int> TidyAttr_SANDBOX
    SCOPED = <int> TidyAttr_SCOPED
    SEAMLESS = <int> TidyAttr_SEAMLESS
    SIZES = <int> TidyAttr_SIZES
    SPELLCHECK = <int> TidyAttr_SPELLCHECK
    SRCDOC = <int> TidyAttr_SRCDOC
    SRCLANG = <int> TidyAttr_SRCLANG
    STEP = <int> TidyAttr_STEP
    ARIA_ACTIVEDESCENDANT = <int> TidyAttr_ARIA_ACTIVEDESCENDANT
    ARIA_ATOMIC = <int> TidyAttr_ARIA_ATOMIC
    ARIA_AUTOCOMPLETE = <int> TidyAttr_ARIA_AUTOCOMPLETE
    ARIA_BUSY = <int> TidyAttr_ARIA_BUSY
    ARIA_CHECKED = <int> TidyAttr_ARIA_CHECKED
    ARIA_CONTROLS = <int> TidyAttr_ARIA_CONTROLS
    ARIA_DESCRIBEDBY = <int> TidyAttr_ARIA_DESCRIBEDBY
    ARIA_DISABLED = <int> TidyAttr_ARIA_DISABLED
    ARIA_DROPEFFECT = <int> TidyAttr_ARIA_DROPEFFECT
    ARIA_EXPANDED = <int> TidyAttr_ARIA_EXPANDED
    ARIA_FLOWTO = <int> TidyAttr_ARIA_FLOWTO
    ARIA_GRABBED = <int> TidyAttr_ARIA_GRABBED
    ARIA_HASPOPUP = <int> TidyAttr_ARIA_HASPOPUP
    ARIA_HIDDEN = <int> TidyAttr_ARIA_HIDDEN
    ARIA_INVALID = <int> TidyAttr_ARIA_INVALID
    ARIA_LABEL = <int> TidyAttr_ARIA_LABEL
    ARIA_LABELLEDBY = <int> TidyAttr_ARIA_LABELLEDBY
    ARIA_LEVEL = <int> TidyAttr_ARIA_LEVEL
    ARIA_LIVE = <int> TidyAttr_ARIA_LIVE
    ARIA_MULTILINE = <int> TidyAttr_ARIA_MULTILINE
    ARIA_MULTISELECTABLE = <int> TidyAttr_ARIA_MULTISELECTABLE
    ARIA_ORIENTATION = <int> TidyAttr_ARIA_ORIENTATION
    ARIA_OWNS = <int> TidyAttr_ARIA_OWNS
    ARIA_POSINSET = <int> TidyAttr_ARIA_POSINSET
    ARIA_PRESSED = <int> TidyAttr_ARIA_PRESSED
    ARIA_READONLY = <int> TidyAttr_ARIA_READONLY
    ARIA_RELEVANT = <int> TidyAttr_ARIA_RELEVANT
    ARIA_REQUIRED = <int> TidyAttr_ARIA_REQUIRED
    ARIA_SELECTED = <int> TidyAttr_ARIA_SELECTED
    ARIA_SETSIZE = <int> TidyAttr_ARIA_SETSIZE
    ARIA_SORT = <int> TidyAttr_ARIA_SORT
    ARIA_VALUEMAX = <int> TidyAttr_ARIA_VALUEMAX
    ARIA_VALUEMIN = <int> TidyAttr_ARIA_VALUEMIN
    ARIA_VALUENOW = <int> TidyAttr_ARIA_VALUENOW
    ARIA_VALUETEXT = <int> TidyAttr_ARIA_VALUETEXT
    X = <int> TidyAttr_X
    Y = <int> TidyAttr_Y
    VIEWBOX = <int> TidyAttr_VIEWBOX
    PRESERVEASPECTRATIO = <int> TidyAttr_PRESERVEASPECTRATIO
    ZOOMANDPAN = <int> TidyAttr_ZOOMANDPAN
    BASEPROFILE = <int> TidyAttr_BASEPROFILE
    CONTENTSCRIPTTYPE = <int> TidyAttr_CONTENTSCRIPTTYPE
    CONTENTSTYLETYPE = <int> TidyAttr_CONTENTSTYLETYPE
    DISPLAY = <int> TidyAttr_DISPLAY
    ABOUT = <int> TidyAttr_ABOUT
    DATATYPE = <int> TidyAttr_DATATYPE
    INLIST = <int> TidyAttr_INLIST
    PREFIX = <int> TidyAttr_PREFIX
    PROPERTY = <int> TidyAttr_PROPERTY
    RESOURCE = <int> TidyAttr_RESOURCE
    TYPEOF = <int> TidyAttr_TYPEOF
    VOCAB = <int> TidyAttr_VOCAB
    INTEGRITY = <int> TidyAttr_INTEGRITY
    AS = <int> TidyAttr_AS
    XMLNSXLINK = <int> TidyAttr_XMLNSXLINK
    _N = <int> N_TIDY_ATTRIBS


class _ReportLevel(IntEnum):
    __name__ = __qualname__ = 'ReportLevel'

    for_name = staticmethod(report_level_for_name)

    Info = <int> TidyInfo
    Warning = <int> TidyWarning
    Config = <int> TidyConfig
    Access = <int> TidyAccess
    Error = <int> TidyError
    BadDocument = <int> TidyBadDocument
    Fatal = <int> TidyFatal
    DialogueSummary = <int> TidyDialogueSummary
    DialogueInfo = <int> TidyDialogueInfo
    DialogueFootnote = <int> TidyDialogueFootnote
    DialogueDoc = DialogueFootnote


class _FormatParameterType(IntEnum):
    __name__ = __qualname__ = 'FormatParameterType'

    for_name = staticmethod(format_parameter_type_for_name)

    INT = <int> tidyFormatType_INT
    UINT = <int> tidyFormatType_UINT
    STRING = <int> tidyFormatType_STRING
    DOUBLE = <int> tidyFormatType_DOUBLE
    UNKNOWN = <int> tidyFormatType_UNKNOWN


class _Strings(IntEnum):
    for_name = staticmethod(strings_for_name)
    
    tidystringsFirst = <int> TIDYSTRINGS_FIRST
    reportMessageFirst = <int> REPORT_MESSAGE_FIRST
    reportMessageLast = <int> REPORT_MESSAGE_LAST
    tidystringsLast = <int> TIDYSTRINGS_LAST
    lineColumnString = <int> LINE_COLUMN_STRING
    stringDiscarding = <int> STRING_DISCARDING
    stringErrorCountError = <int> STRING_ERROR_COUNT_ERROR
    stringErrorCountWarning = <int> STRING_ERROR_COUNT_WARNING
    stringHelloAccess = <int> STRING_HELLO_ACCESS
    stringHtmlProprietary = <int> STRING_HTML_PROPRIETARY
    stringPlainText = <int> STRING_PLAIN_TEXT
    stringReplacing = <int> STRING_REPLACING
    stringSpecified = <int> STRING_SPECIFIED
    stringXmlDeclaration = <int> STRING_XML_DECLARATION
    tidycustomnoString = <int> TIDYCUSTOMNO_STRING
    tidycustomblocklevelString = <int> TIDYCUSTOMBLOCKLEVEL_STRING
    tidycustomemptyString = <int> TIDYCUSTOMEMPTY_STRING
    tidycustominlineString = <int> TIDYCUSTOMINLINE_STRING
    tidycustompreString = <int> TIDYCUSTOMPRE_STRING
    footnoteTrimEmptyElement = <int> FOOTNOTE_TRIM_EMPTY_ELEMENT
    textAccessAdvice1 = <int> TEXT_ACCESS_ADVICE1
    textAccessAdvice2 = <int> TEXT_ACCESS_ADVICE2
    textBadForm = <int> TEXT_BAD_FORM
    textBadMain = <int> TEXT_BAD_MAIN
    textHtmlTAlgorithm = <int> TEXT_HTML_T_ALGORITHM
    textInvalidUri = <int> TEXT_INVALID_URI
    textInvalidUtf16 = <int> TEXT_INVALID_UTF16
    textInvalidUtf8 = <int> TEXT_INVALID_UTF8
    textMImageAlt = <int> TEXT_M_IMAGE_ALT
    textMImageMap = <int> TEXT_M_IMAGE_MAP
    textMLinkAlt = <int> TEXT_M_LINK_ALT
    textMSummary = <int> TEXT_M_SUMMARY
    textSgmlChars = <int> TEXT_SGML_CHARS
    textUsingBody = <int> TEXT_USING_BODY
    textUsingFont = <int> TEXT_USING_FONT
    textUsingFrames = <int> TEXT_USING_FRAMES
    textUsingLayer = <int> TEXT_USING_LAYER
    textUsingNobr = <int> TEXT_USING_NOBR
    textUsingSpacer = <int> TEXT_USING_SPACER
    textVendorChars = <int> TEXT_VENDOR_CHARS
    textWindowsChars = <int> TEXT_WINDOWS_CHARS
    stringErrorCount = <int> STRING_ERROR_COUNT
    stringNeedsIntervention = <int> STRING_NEEDS_INTERVENTION
    stringNoErrors = <int> STRING_NO_ERRORS
    stringNotAllShown = <int> STRING_NOT_ALL_SHOWN
    textGeneralInfoPlea = <int> TEXT_GENERAL_INFO_PLEA
    textGeneralInfo = <int> TEXT_GENERAL_INFO
    addedMissingCharset = <int> ADDED_MISSING_CHARSET
    anchorNotUnique = <int> ANCHOR_NOT_UNIQUE
    aposUndefined = <int> APOS_UNDEFINED
    attrValueNotLcase = <int> ATTR_VALUE_NOT_LCASE
    attributeIsNotAllowed = <int> ATTRIBUTE_IS_NOT_ALLOWED
    attributeValueReplaced = <int> ATTRIBUTE_VALUE_REPLACED
    backslashInUri = <int> BACKSLASH_IN_URI
    badAttributeValueReplaced = <int> BAD_ATTRIBUTE_VALUE_REPLACED
    badAttributeValue = <int> BAD_ATTRIBUTE_VALUE
    badCdataContent = <int> BAD_CDATA_CONTENT
    badSummaryHtml5 = <int> BAD_SUMMARY_HTML5
    badSurrogateLead = <int> BAD_SURROGATE_LEAD
    badSurrogatePair = <int> BAD_SURROGATE_PAIR
    badSurrogateTail = <int> BAD_SURROGATE_TAIL
    cantBeNested = <int> CANT_BE_NESTED
    coerceToEndtag = <int> COERCE_TO_ENDTAG
    contentAfterBody = <int> CONTENT_AFTER_BODY
    customTagDetected = <int> CUSTOM_TAG_DETECTED
    discardingUnexpected = <int> DISCARDING_UNEXPECTED
    doctypeAfterTags = <int> DOCTYPE_AFTER_TAGS
    duplicateFrameset = <int> DUPLICATE_FRAMESET
    elementNotEmpty = <int> ELEMENT_NOT_EMPTY
    elementVersMismatchError = <int> ELEMENT_VERS_MISMATCH_ERROR
    elementVersMismatchWarn = <int> ELEMENT_VERS_MISMATCH_WARN
    encodingMismatch = <int> ENCODING_MISMATCH
    escapedIllegalUri = <int> ESCAPED_ILLEGAL_URI
    fileCantOpen = <int> FILE_CANT_OPEN
    fileCantOpenCfg = <int> FILE_CANT_OPEN_CFG
    fileNotFile = <int> FILE_NOT_FILE
    fixedBackslash = <int> FIXED_BACKSLASH
    foundStyleInBody = <int> FOUND_STYLE_IN_BODY
    idNameMismatch = <int> ID_NAME_MISMATCH
    illegalNesting = <int> ILLEGAL_NESTING
    illegalUriCodepoint = <int> ILLEGAL_URI_CODEPOINT
    illegalUriReference = <int> ILLEGAL_URI_REFERENCE
    insertingAutoAttribute = <int> INSERTING_AUTO_ATTRIBUTE
    insertingTag = <int> INSERTING_TAG
    invalidAttribute = <int> INVALID_ATTRIBUTE
    invalidNcr = <int> INVALID_NCR
    invalidSgmlChars = <int> INVALID_SGML_CHARS
    invalidUtf8 = <int> INVALID_UTF8
    invalidUtf16 = <int> INVALID_UTF16
    invalidXmlId = <int> INVALID_XML_ID
    joiningAttribute = <int> JOINING_ATTRIBUTE
    malformedComment = <int> MALFORMED_COMMENT
    malformedCommentDropping = <int> MALFORMED_COMMENT_DROPPING
    malformedCommentEos = <int> MALFORMED_COMMENT_EOS
    malformedCommentWarn = <int> MALFORMED_COMMENT_WARN
    malformedDoctype = <int> MALFORMED_DOCTYPE
    mismatchedAttributeError = <int> MISMATCHED_ATTRIBUTE_ERROR
    mismatchedAttributeWarn = <int> MISMATCHED_ATTRIBUTE_WARN
    missingAttrValue = <int> MISSING_ATTR_VALUE
    missingAttribute = <int> MISSING_ATTRIBUTE
    missingDoctype = <int> MISSING_DOCTYPE
    missingEndtagBefore = <int> MISSING_ENDTAG_BEFORE
    missingEndtagFor = <int> MISSING_ENDTAG_FOR
    missingEndtagOptional = <int> MISSING_ENDTAG_OPTIONAL
    missingImagemap = <int> MISSING_IMAGEMAP
    missingQuotemark = <int> MISSING_QUOTEMARK
    missingQuotemarkOpen = <int> MISSING_QUOTEMARK_OPEN
    missingSemicolonNcr = <int> MISSING_SEMICOLON_NCR
    missingSemicolon = <int> MISSING_SEMICOLON
    missingStarttag = <int> MISSING_STARTTAG
    missingTitleElement = <int> MISSING_TITLE_ELEMENT
    movedStyleToHead = <int> MOVED_STYLE_TO_HEAD
    nestedEmphasis = <int> NESTED_EMPHASIS
    nestedQuotation = <int> NESTED_QUOTATION
    newlineInUri = <int> NEWLINE_IN_URI
    noframesContent = <int> NOFRAMES_CONTENT
    nonMatchingEndtag = <int> NON_MATCHING_ENDTAG
    obsoleteElement = <int> OBSOLETE_ELEMENT
    optionRemoved = <int> OPTION_REMOVED
    optionRemovedApplied = <int> OPTION_REMOVED_APPLIED
    optionRemovedUnapplied = <int> OPTION_REMOVED_UNAPPLIED
    previousLocation = <int> PREVIOUS_LOCATION
    proprietaryAttrValue = <int> PROPRIETARY_ATTR_VALUE
    proprietaryAttribute = <int> PROPRIETARY_ATTRIBUTE
    proprietaryElement = <int> PROPRIETARY_ELEMENT
    removedHtml5 = <int> REMOVED_HTML5
    repeatedAttribute = <int> REPEATED_ATTRIBUTE
    replacingElement = <int> REPLACING_ELEMENT
    replacingUnexElement = <int> REPLACING_UNEX_ELEMENT
    spacePrecedingXmldecl = <int> SPACE_PRECEDING_XMLDECL
    stringContentLooks = <int> STRING_CONTENT_LOOKS
    stringArgumentBad = <int> STRING_ARGUMENT_BAD
    stringDoctypeGiven = <int> STRING_DOCTYPE_GIVEN
    stringMissingMalformed = <int> STRING_MISSING_MALFORMED
    stringMutingType = <int> STRING_MUTING_TYPE
    stringNoSysid = <int> STRING_NO_SYSID
    stringUnknownOption = <int> STRING_UNKNOWN_OPTION
    suspectedMissingQuote = <int> SUSPECTED_MISSING_QUOTE
    tagNotAllowedIn = <int> TAG_NOT_ALLOWED_IN
    tooManyElementsIn = <int> TOO_MANY_ELEMENTS_IN
    tooManyElements = <int> TOO_MANY_ELEMENTS
    trimEmptyElement = <int> TRIM_EMPTY_ELEMENT
    unescapedAmpersand = <int> UNESCAPED_AMPERSAND
    unexpectedEndOfFileAttr = <int> UNEXPECTED_END_OF_FILE_ATTR
    unexpectedEndOfFile = <int> UNEXPECTED_END_OF_FILE
    unexpectedEndtagErr = <int> UNEXPECTED_ENDTAG_ERR
    unexpectedEndtagIn = <int> UNEXPECTED_ENDTAG_IN
    unexpectedEndtag = <int> UNEXPECTED_ENDTAG
    unexpectedEqualsign = <int> UNEXPECTED_EQUALSIGN
    unexpectedGt = <int> UNEXPECTED_GT
    unexpectedQuotemark = <int> UNEXPECTED_QUOTEMARK
    unknownElementLooksCustom = <int> UNKNOWN_ELEMENT_LOOKS_CUSTOM
    unknownElement = <int> UNKNOWN_ELEMENT
    unknownEntity = <int> UNKNOWN_ENTITY
    usingBrInplaceOf = <int> USING_BR_INPLACE_OF
    vendorSpecificChars = <int> VENDOR_SPECIFIC_CHARS
    whiteInUri = <int> WHITE_IN_URI
    xmlDeclarationDetected = <int> XML_DECLARATION_DETECTED
    xmlIdSyntax = <int> XML_ID_SYNTAX
    imgMissingAlt = <int> IMG_MISSING_ALT
    imgAltSuspiciousFilename = <int> IMG_ALT_SUSPICIOUS_FILENAME
    imgAltSuspiciousFileSize = <int> IMG_ALT_SUSPICIOUS_FILE_SIZE
    imgAltSuspiciousPlaceholder = <int> IMG_ALT_SUSPICIOUS_PLACEHOLDER
    imgAltSuspiciousTooLong = <int> IMG_ALT_SUSPICIOUS_TOO_LONG
    imgMissingLongdescDlink = <int> IMG_MISSING_LONGDESC_DLINK
    imgMissingDlink = <int> IMG_MISSING_DLINK
    imgMissingLongdesc = <int> IMG_MISSING_LONGDESC
    imgButtonMissingAlt = <int> IMG_BUTTON_MISSING_ALT
    appletMissingAlt = <int> APPLET_MISSING_ALT
    objectMissingAlt = <int> OBJECT_MISSING_ALT
    audioMissingTextWav = <int> AUDIO_MISSING_TEXT_WAV
    audioMissingTextAu = <int> AUDIO_MISSING_TEXT_AU
    audioMissingTextAiff = <int> AUDIO_MISSING_TEXT_AIFF
    audioMissingTextSnd = <int> AUDIO_MISSING_TEXT_SND
    audioMissingTextRa = <int> AUDIO_MISSING_TEXT_RA
    audioMissingTextRm = <int> AUDIO_MISSING_TEXT_RM
    frameMissingLongdesc = <int> FRAME_MISSING_LONGDESC
    areaMissingAlt = <int> AREA_MISSING_ALT
    scriptMissingNoscript = <int> SCRIPT_MISSING_NOSCRIPT
    asciiRequiresDescription = <int> ASCII_REQUIRES_DESCRIPTION
    imgMapServerRequiresTextLinks = <int> IMG_MAP_SERVER_REQUIRES_TEXT_LINKS
    multimediaRequiresText = <int> MULTIMEDIA_REQUIRES_TEXT
    imgMapClientMissingTextLinks = <int> IMG_MAP_CLIENT_MISSING_TEXT_LINKS
    informationNotConveyedImage = <int> INFORMATION_NOT_CONVEYED_IMAGE
    informationNotConveyedApplet = <int> INFORMATION_NOT_CONVEYED_APPLET
    informationNotConveyedObject = <int> INFORMATION_NOT_CONVEYED_OBJECT
    informationNotConveyedScript = <int> INFORMATION_NOT_CONVEYED_SCRIPT
    informationNotConveyedInput = <int> INFORMATION_NOT_CONVEYED_INPUT
    colorContrastText = <int> COLOR_CONTRAST_TEXT
    colorContrastLink = <int> COLOR_CONTRAST_LINK
    colorContrastActiveLink = <int> COLOR_CONTRAST_ACTIVE_LINK
    colorContrastVisitedLink = <int> COLOR_CONTRAST_VISITED_LINK
    doctypeMissing = <int> DOCTYPE_MISSING
    styleSheetControlPresentation = <int> STYLE_SHEET_CONTROL_PRESENTATION
    headersImproperlyNested = <int> HEADERS_IMPROPERLY_NESTED
    potentialHeaderBold = <int> POTENTIAL_HEADER_BOLD
    potentialHeaderItalics = <int> POTENTIAL_HEADER_ITALICS
    potentialHeaderUnderline = <int> POTENTIAL_HEADER_UNDERLINE
    headerUsedFormatText = <int> HEADER_USED_FORMAT_TEXT
    listUsageInvalidUl = <int> LIST_USAGE_INVALID_UL
    listUsageInvalidOl = <int> LIST_USAGE_INVALID_OL
    listUsageInvalidLi = <int> LIST_USAGE_INVALID_LI
    languageNotIdentified = <int> LANGUAGE_NOT_IDENTIFIED
    languageInvalid = <int> LANGUAGE_INVALID
    dataTableMissingHeaders = <int> DATA_TABLE_MISSING_HEADERS
    dataTableMissingHeadersColumn = <int> DATA_TABLE_MISSING_HEADERS_COLUMN
    dataTableMissingHeadersRow = <int> DATA_TABLE_MISSING_HEADERS_ROW
    dataTableRequireMarkupColumnHeaders = <int> DATA_TABLE_REQUIRE_MARKUP_COLUMN_HEADERS
    dataTableRequireMarkupRowHeaders = <int> DATA_TABLE_REQUIRE_MARKUP_ROW_HEADERS
    layoutTablesLinearizeProperly = <int> LAYOUT_TABLES_LINEARIZE_PROPERLY
    layoutTableInvalidMarkup = <int> LAYOUT_TABLE_INVALID_MARKUP
    tableMissingSummary = <int> TABLE_MISSING_SUMMARY
    tableSummaryInvalidNull = <int> TABLE_SUMMARY_INVALID_NULL
    tableSummaryInvalidSpaces = <int> TABLE_SUMMARY_INVALID_SPACES
    tableSummaryInvalidPlaceholder = <int> TABLE_SUMMARY_INVALID_PLACEHOLDER
    tableMissingCaption = <int> TABLE_MISSING_CAPTION
    tableMayRequireHeaderAbbr = <int> TABLE_MAY_REQUIRE_HEADER_ABBR
    tableMayRequireHeaderAbbrNull = <int> TABLE_MAY_REQUIRE_HEADER_ABBR_NULL
    tableMayRequireHeaderAbbrSpaces = <int> TABLE_MAY_REQUIRE_HEADER_ABBR_SPACES
    stylesheetsRequireTestingLink = <int> STYLESHEETS_REQUIRE_TESTING_LINK
    stylesheetsRequireTestingStyleElement = <int> STYLESHEETS_REQUIRE_TESTING_STYLE_ELEMENT
    stylesheetsRequireTestingStyleAttr = <int> STYLESHEETS_REQUIRE_TESTING_STYLE_ATTR
    frameSrcInvalid = <int> FRAME_SRC_INVALID
    textEquivalentsRequireUpdatingApplet = <int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_APPLET
    textEquivalentsRequireUpdatingScript = <int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_SCRIPT
    textEquivalentsRequireUpdatingObject = <int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_OBJECT
    programmaticObjectsRequireTestingScript = <int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_SCRIPT
    programmaticObjectsRequireTestingObject = <int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_OBJECT
    programmaticObjectsRequireTestingEmbed = <int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_EMBED
    programmaticObjectsRequireTestingApplet = <int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_APPLET
    frameMissingNoframes = <int> FRAME_MISSING_NOFRAMES
    noframesInvalidNoValue = <int> NOFRAMES_INVALID_NO_VALUE
    noframesInvalidContent = <int> NOFRAMES_INVALID_CONTENT
    noframesInvalidLink = <int> NOFRAMES_INVALID_LINK
    removeFlickerScript = <int> REMOVE_FLICKER_SCRIPT
    removeFlickerObject = <int> REMOVE_FLICKER_OBJECT
    removeFlickerEmbed = <int> REMOVE_FLICKER_EMBED
    removeFlickerApplet = <int> REMOVE_FLICKER_APPLET
    removeFlickerAnimatedGif = <int> REMOVE_FLICKER_ANIMATED_GIF
    removeBlinkMarquee = <int> REMOVE_BLINK_MARQUEE
    removeAutoRefresh = <int> REMOVE_AUTO_REFRESH
    removeAutoRedirect = <int> REMOVE_AUTO_REDIRECT
    ensureProgrammaticObjectsAccessibleScript = <int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_SCRIPT
    ensureProgrammaticObjectsAccessibleObject = <int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_OBJECT
    ensureProgrammaticObjectsAccessibleApplet = <int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_APPLET
    ensureProgrammaticObjectsAccessibleEmbed = <int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_EMBED
    imageMapServerSideRequiresConversion = <int> IMAGE_MAP_SERVER_SIDE_REQUIRES_CONVERSION
    scriptNotKeyboardAccessibleOnMouseDown = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_DOWN
    scriptNotKeyboardAccessibleOnMouseUp = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_UP
    scriptNotKeyboardAccessibleOnClick = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_CLICK
    scriptNotKeyboardAccessibleOnMouseOver = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_OVER
    scriptNotKeyboardAccessibleOnMouseOut = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_OUT
    scriptNotKeyboardAccessibleOnMouseMove = <int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_MOVE
    newWindowsRequireWarningNew = <int> NEW_WINDOWS_REQUIRE_WARNING_NEW
    newWindowsRequireWarningBlank = <int> NEW_WINDOWS_REQUIRE_WARNING_BLANK
    replaceDeprecatedHtmlApplet = <int> REPLACE_DEPRECATED_HTML_APPLET
    replaceDeprecatedHtmlBasefont = <int> REPLACE_DEPRECATED_HTML_BASEFONT
    replaceDeprecatedHtmlCenter = <int> REPLACE_DEPRECATED_HTML_CENTER
    replaceDeprecatedHtmlDir = <int> REPLACE_DEPRECATED_HTML_DIR
    replaceDeprecatedHtmlFont = <int> REPLACE_DEPRECATED_HTML_FONT
    replaceDeprecatedHtmlIsindex = <int> REPLACE_DEPRECATED_HTML_ISINDEX
    replaceDeprecatedHtmlMenu = <int> REPLACE_DEPRECATED_HTML_MENU
    replaceDeprecatedHtmlS = <int> REPLACE_DEPRECATED_HTML_S
    replaceDeprecatedHtmlStrike = <int> REPLACE_DEPRECATED_HTML_STRIKE
    replaceDeprecatedHtmlU = <int> REPLACE_DEPRECATED_HTML_U
    frameMissingTitle = <int> FRAME_MISSING_TITLE
    frameTitleInvalidNull = <int> FRAME_TITLE_INVALID_NULL
    frameTitleInvalidSpaces = <int> FRAME_TITLE_INVALID_SPACES
    associateLabelsExplicitly = <int> ASSOCIATE_LABELS_EXPLICITLY
    associateLabelsExplicitlyFor = <int> ASSOCIATE_LABELS_EXPLICITLY_FOR
    associateLabelsExplicitlyId = <int> ASSOCIATE_LABELS_EXPLICITLY_ID
    linkTextNotMeaningful = <int> LINK_TEXT_NOT_MEANINGFUL
    linkTextMissing = <int> LINK_TEXT_MISSING
    linkTextTooLong = <int> LINK_TEXT_TOO_LONG
    linkTextNotMeaningfulClickHere = <int> LINK_TEXT_NOT_MEANINGFUL_CLICK_HERE
    metadataMissing = <int> METADATA_MISSING
    metadataMissingRedirectAutorefresh = <int> METADATA_MISSING_REDIRECT_AUTOREFRESH
    skipoverAsciiArt = <int> SKIPOVER_ASCII_ART


class _ParseOutcome(IntEnum):
    __name__ = __qualname__ = 'ParseOutcome'

    for_name = staticmethod(parse_outcome_for_name)

    Ok = 0
    Warnings = 1
    Errors = 2


OptionId = _OptionId
ConfigCategory = _ConfigCategory
OptionType = _OptionType
TriState = _TriState
UseCustomTagsState = _UseCustomTagsState
LineEnding = _LineEnding
EncodingOptions = _EncodingOptions
DoctypeModes = _DoctypeModes
DupAttrModes = _DupAttrModes
AttrSortStrategy = _AttrSortStrategy
OptionId = _OptionId
Uppercase = _Uppercase
NodeType = _NodeType
TagId = _TagId
AttrId = _AttrId
ReportLevel = _ReportLevel
FormatParameterType = _FormatParameterType
Strings = _Strings
ParseOutcome = _ParseOutcome
