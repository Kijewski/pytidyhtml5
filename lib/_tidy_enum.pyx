# GENERATED FILE: all modifications will be overwritten.

cdef type _AttrId
cdef type _AttrSortStrategy
cdef type _ConfigCategory
cdef type _DoctypeModes
cdef type _DupAttrModes
cdef type _EncodingOptions
cdef type _FormatParameterType
cdef type _LineEnding
cdef type _NodeType
cdef type _OptionId
cdef type _OptionType
cdef type _ReportLevel
cdef type _Strings
cdef type _TagId
cdef type _TriState
cdef type _Uppercase
cdef type _UseCustomTagsState


cdef object attr_id_for_name(name):
    return _generic_id_for_name(_AttrId, name)


cdef object attr_sort_strategy_for_name(name):
    return _generic_id_for_name(_AttrSortStrategy, name)


cdef object config_category_for_name(name):
    return _generic_id_for_name(_ConfigCategory, name)


cdef object doctype_modes_for_name(name):
    return _generic_id_for_name(_DoctypeModes, name)


cdef object dup_attr_modes_for_name(name):
    return _generic_id_for_name(_DupAttrModes, name)


cdef object encoding_options_for_name(name):
    return _generic_id_for_name(_EncodingOptions, name)


cdef object format_parameter_type_for_name(name):
    return _generic_id_for_name(_FormatParameterType, name)


cdef object line_ending_for_name(name):
    return _generic_id_for_name(_LineEnding, name)


cdef object node_type_for_name(name):
    return _generic_id_for_name(_NodeType, name)


cdef object option_id_for_name(name):
    return _generic_id_for_name(_OptionId, name)


cdef object option_type_for_name(name):
    return _generic_id_for_name(_OptionType, name)


cdef object report_level_for_name(name):
    return _generic_id_for_name(_ReportLevel, name)


cdef object strings_for_name(name):
    return _generic_id_for_name(_Strings, name)


cdef object tag_id_for_name(name):
    return _generic_id_for_name(_TagId, name)


cdef object tri_state_for_name(name):
    return _generic_id_for_name(_TriState, name)


cdef object uppercase_for_name(name):
    return _generic_id_for_name(_Uppercase, name)


cdef object use_custom_tags_state_for_name(name):
    return _generic_id_for_name(_UseCustomTagsState, name)


class _AttrId(IntEnum):
    __name__ =  __qualname__ = 'AttrId'
    for_name = staticmethod(attr_id_for_name)

    n_tidy_attribs = <unsigned int> N_TIDY_ATTRIBS
    abbr = <unsigned int> TidyAttr_ABBR
    about = <unsigned int> TidyAttr_ABOUT
    accept = <unsigned int> TidyAttr_ACCEPT
    accept_charset = <unsigned int> TidyAttr_ACCEPT_CHARSET
    accesskey = <unsigned int> TidyAttr_ACCESSKEY
    action = <unsigned int> TidyAttr_ACTION
    add_date = <unsigned int> TidyAttr_ADD_DATE
    align = <unsigned int> TidyAttr_ALIGN
    alink = <unsigned int> TidyAttr_ALINK
    allowfullscreen = <unsigned int> TidyAttr_ALLOWFULLSCREEN
    alt = <unsigned int> TidyAttr_ALT
    archive = <unsigned int> TidyAttr_ARCHIVE
    aria_activedescendant = <unsigned int> TidyAttr_ARIA_ACTIVEDESCENDANT
    aria_atomic = <unsigned int> TidyAttr_ARIA_ATOMIC
    aria_autocomplete = <unsigned int> TidyAttr_ARIA_AUTOCOMPLETE
    aria_busy = <unsigned int> TidyAttr_ARIA_BUSY
    aria_checked = <unsigned int> TidyAttr_ARIA_CHECKED
    aria_controls = <unsigned int> TidyAttr_ARIA_CONTROLS
    aria_describedby = <unsigned int> TidyAttr_ARIA_DESCRIBEDBY
    aria_disabled = <unsigned int> TidyAttr_ARIA_DISABLED
    aria_dropeffect = <unsigned int> TidyAttr_ARIA_DROPEFFECT
    aria_expanded = <unsigned int> TidyAttr_ARIA_EXPANDED
    aria_flowto = <unsigned int> TidyAttr_ARIA_FLOWTO
    aria_grabbed = <unsigned int> TidyAttr_ARIA_GRABBED
    aria_haspopup = <unsigned int> TidyAttr_ARIA_HASPOPUP
    aria_hidden = <unsigned int> TidyAttr_ARIA_HIDDEN
    aria_invalid = <unsigned int> TidyAttr_ARIA_INVALID
    aria_label = <unsigned int> TidyAttr_ARIA_LABEL
    aria_labelledby = <unsigned int> TidyAttr_ARIA_LABELLEDBY
    aria_level = <unsigned int> TidyAttr_ARIA_LEVEL
    aria_live = <unsigned int> TidyAttr_ARIA_LIVE
    aria_multiline = <unsigned int> TidyAttr_ARIA_MULTILINE
    aria_multiselectable = <unsigned int> TidyAttr_ARIA_MULTISELECTABLE
    aria_orientation = <unsigned int> TidyAttr_ARIA_ORIENTATION
    aria_owns = <unsigned int> TidyAttr_ARIA_OWNS
    aria_posinset = <unsigned int> TidyAttr_ARIA_POSINSET
    aria_pressed = <unsigned int> TidyAttr_ARIA_PRESSED
    aria_readonly = <unsigned int> TidyAttr_ARIA_READONLY
    aria_relevant = <unsigned int> TidyAttr_ARIA_RELEVANT
    aria_required = <unsigned int> TidyAttr_ARIA_REQUIRED
    aria_selected = <unsigned int> TidyAttr_ARIA_SELECTED
    aria_setsize = <unsigned int> TidyAttr_ARIA_SETSIZE
    aria_sort = <unsigned int> TidyAttr_ARIA_SORT
    aria_valuemax = <unsigned int> TidyAttr_ARIA_VALUEMAX
    aria_valuemin = <unsigned int> TidyAttr_ARIA_VALUEMIN
    aria_valuenow = <unsigned int> TidyAttr_ARIA_VALUENOW
    aria_valuetext = <unsigned int> TidyAttr_ARIA_VALUETEXT
    as_ = <unsigned int> TidyAttr_AS
    async = <unsigned int> TidyAttr_ASYNC
    autocomplete = <unsigned int> TidyAttr_AUTOCOMPLETE
    autofocus = <unsigned int> TidyAttr_AUTOFOCUS
    autoplay = <unsigned int> TidyAttr_AUTOPLAY
    axis = <unsigned int> TidyAttr_AXIS
    background = <unsigned int> TidyAttr_BACKGROUND
    baseprofile = <unsigned int> TidyAttr_BASEPROFILE
    bgcolor = <unsigned int> TidyAttr_BGCOLOR
    bgproperties = <unsigned int> TidyAttr_BGPROPERTIES
    border = <unsigned int> TidyAttr_BORDER
    bordercolor = <unsigned int> TidyAttr_BORDERCOLOR
    bottommargin = <unsigned int> TidyAttr_BOTTOMMARGIN
    cellpadding = <unsigned int> TidyAttr_CELLPADDING
    cellspacing = <unsigned int> TidyAttr_CELLSPACING
    challenge = <unsigned int> TidyAttr_CHALLENGE
    char = <unsigned int> TidyAttr_CHAR
    charoff = <unsigned int> TidyAttr_CHAROFF
    charset = <unsigned int> TidyAttr_CHARSET
    checked = <unsigned int> TidyAttr_CHECKED
    cite = <unsigned int> TidyAttr_CITE
    class_ = <unsigned int> TidyAttr_CLASS
    classid = <unsigned int> TidyAttr_CLASSID
    clear = <unsigned int> TidyAttr_CLEAR
    code = <unsigned int> TidyAttr_CODE
    codebase = <unsigned int> TidyAttr_CODEBASE
    codetype = <unsigned int> TidyAttr_CODETYPE
    color = <unsigned int> TidyAttr_COLOR
    cols = <unsigned int> TidyAttr_COLS
    colspan = <unsigned int> TidyAttr_COLSPAN
    compact = <unsigned int> TidyAttr_COMPACT
    content = <unsigned int> TidyAttr_CONTENT
    contenteditable = <unsigned int> TidyAttr_CONTENTEDITABLE
    contentscripttype = <unsigned int> TidyAttr_CONTENTSCRIPTTYPE
    contentstyletype = <unsigned int> TidyAttr_CONTENTSTYLETYPE
    contextmenu = <unsigned int> TidyAttr_CONTEXTMENU
    controls = <unsigned int> TidyAttr_CONTROLS
    coords = <unsigned int> TidyAttr_COORDS
    crossorigin = <unsigned int> TidyAttr_CROSSORIGIN
    data = <unsigned int> TidyAttr_DATA
    datafld = <unsigned int> TidyAttr_DATAFLD
    dataformatas = <unsigned int> TidyAttr_DATAFORMATAS
    datapagesize = <unsigned int> TidyAttr_DATAPAGESIZE
    datasrc = <unsigned int> TidyAttr_DATASRC
    datatype = <unsigned int> TidyAttr_DATATYPE
    datetime = <unsigned int> TidyAttr_DATETIME
    declare = <unsigned int> TidyAttr_DECLARE
    default = <unsigned int> TidyAttr_DEFAULT
    defer = <unsigned int> TidyAttr_DEFER
    dir = <unsigned int> TidyAttr_DIR
    dirname = <unsigned int> TidyAttr_DIRNAME
    disabled = <unsigned int> TidyAttr_DISABLED
    display = <unsigned int> TidyAttr_DISPLAY
    download = <unsigned int> TidyAttr_DOWNLOAD
    draggable = <unsigned int> TidyAttr_DRAGGABLE
    dropzone = <unsigned int> TidyAttr_DROPZONE
    encoding = <unsigned int> TidyAttr_ENCODING
    enctype = <unsigned int> TidyAttr_ENCTYPE
    event = <unsigned int> TidyAttr_EVENT
    face = <unsigned int> TidyAttr_FACE
    for_ = <unsigned int> TidyAttr_FOR
    form = <unsigned int> TidyAttr_FORM
    formaction = <unsigned int> TidyAttr_FORMACTION
    formenctype = <unsigned int> TidyAttr_FORMENCTYPE
    formmethod = <unsigned int> TidyAttr_FORMMETHOD
    formnovalidate = <unsigned int> TidyAttr_FORMNOVALIDATE
    formtarget = <unsigned int> TidyAttr_FORMTARGET
    frame = <unsigned int> TidyAttr_FRAME
    frameborder = <unsigned int> TidyAttr_FRAMEBORDER
    framespacing = <unsigned int> TidyAttr_FRAMESPACING
    gridx = <unsigned int> TidyAttr_GRIDX
    gridy = <unsigned int> TidyAttr_GRIDY
    headers = <unsigned int> TidyAttr_HEADERS
    height = <unsigned int> TidyAttr_HEIGHT
    hidden = <unsigned int> TidyAttr_HIDDEN
    high = <unsigned int> TidyAttr_HIGH
    href = <unsigned int> TidyAttr_HREF
    hreflang = <unsigned int> TidyAttr_HREFLANG
    hspace = <unsigned int> TidyAttr_HSPACE
    http_equiv = <unsigned int> TidyAttr_HTTP_EQUIV
    icon = <unsigned int> TidyAttr_ICON
    id = <unsigned int> TidyAttr_ID
    inlist = <unsigned int> TidyAttr_INLIST
    integrity = <unsigned int> TidyAttr_INTEGRITY
    is_ = <unsigned int> TidyAttr_IS
    ismap = <unsigned int> TidyAttr_ISMAP
    itemid = <unsigned int> TidyAttr_ITEMID
    itemprop = <unsigned int> TidyAttr_ITEMPROP
    itemref = <unsigned int> TidyAttr_ITEMREF
    itemscope = <unsigned int> TidyAttr_ITEMSCOPE
    itemtype = <unsigned int> TidyAttr_ITEMTYPE
    keytype = <unsigned int> TidyAttr_KEYTYPE
    kind = <unsigned int> TidyAttr_KIND
    label = <unsigned int> TidyAttr_LABEL
    lang = <unsigned int> TidyAttr_LANG
    language = <unsigned int> TidyAttr_LANGUAGE
    last_modified = <unsigned int> TidyAttr_LAST_MODIFIED
    last_visit = <unsigned int> TidyAttr_LAST_VISIT
    leftmargin = <unsigned int> TidyAttr_LEFTMARGIN
    link = <unsigned int> TidyAttr_LINK
    list = <unsigned int> TidyAttr_LIST
    longdesc = <unsigned int> TidyAttr_LONGDESC
    loop = <unsigned int> TidyAttr_LOOP
    low = <unsigned int> TidyAttr_LOW
    lowsrc = <unsigned int> TidyAttr_LOWSRC
    manifest = <unsigned int> TidyAttr_MANIFEST
    marginheight = <unsigned int> TidyAttr_MARGINHEIGHT
    marginwidth = <unsigned int> TidyAttr_MARGINWIDTH
    max = <unsigned int> TidyAttr_MAX
    maxlength = <unsigned int> TidyAttr_MAXLENGTH
    media = <unsigned int> TidyAttr_MEDIA
    mediagroup = <unsigned int> TidyAttr_MEDIAGROUP
    method = <unsigned int> TidyAttr_METHOD
    methods = <unsigned int> TidyAttr_METHODS
    min = <unsigned int> TidyAttr_MIN
    multiple = <unsigned int> TidyAttr_MULTIPLE
    n = <unsigned int> TidyAttr_N
    name = <unsigned int> TidyAttr_NAME
    nohref = <unsigned int> TidyAttr_NOHREF
    noresize = <unsigned int> TidyAttr_NORESIZE
    noshade = <unsigned int> TidyAttr_NOSHADE
    novalidate = <unsigned int> TidyAttr_NOVALIDATE
    nowrap = <unsigned int> TidyAttr_NOWRAP
    object = <unsigned int> TidyAttr_OBJECT
    open = <unsigned int> TidyAttr_OPEN
    optimum = <unsigned int> TidyAttr_OPTIMUM
    on_abort = <unsigned int> TidyAttr_OnABORT
    on_afterprint = <unsigned int> TidyAttr_OnAFTERPRINT
    on_afterupdate = <unsigned int> TidyAttr_OnAFTERUPDATE
    on_beforeprint = <unsigned int> TidyAttr_OnBEFOREPRINT
    on_beforeunload = <unsigned int> TidyAttr_OnBEFOREUNLOAD
    on_beforeupdate = <unsigned int> TidyAttr_OnBEFOREUPDATE
    on_blur = <unsigned int> TidyAttr_OnBLUR
    on_canplay = <unsigned int> TidyAttr_OnCANPLAY
    on_canplaythrough = <unsigned int> TidyAttr_OnCANPLAYTHROUGH
    on_change = <unsigned int> TidyAttr_OnCHANGE
    on_click = <unsigned int> TidyAttr_OnCLICK
    on_contextmenu = <unsigned int> TidyAttr_OnCONTEXTMENU
    on_cuechange = <unsigned int> TidyAttr_OnCUECHANGE
    on_dataavailable = <unsigned int> TidyAttr_OnDATAAVAILABLE
    on_datasetchanged = <unsigned int> TidyAttr_OnDATASETCHANGED
    on_datasetcomplete = <unsigned int> TidyAttr_OnDATASETCOMPLETE
    on_dblclick = <unsigned int> TidyAttr_OnDBLCLICK
    on_drag = <unsigned int> TidyAttr_OnDRAG
    on_dragend = <unsigned int> TidyAttr_OnDRAGEND
    on_dragenter = <unsigned int> TidyAttr_OnDRAGENTER
    on_dragleave = <unsigned int> TidyAttr_OnDRAGLEAVE
    on_dragover = <unsigned int> TidyAttr_OnDRAGOVER
    on_dragstart = <unsigned int> TidyAttr_OnDRAGSTART
    on_drop = <unsigned int> TidyAttr_OnDROP
    on_durationchange = <unsigned int> TidyAttr_OnDURATIONCHANGE
    on_emptied = <unsigned int> TidyAttr_OnEMPTIED
    on_ended = <unsigned int> TidyAttr_OnENDED
    on_error = <unsigned int> TidyAttr_OnERROR
    on_errorupdate = <unsigned int> TidyAttr_OnERRORUPDATE
    on_focus = <unsigned int> TidyAttr_OnFOCUS
    on_hashchange = <unsigned int> TidyAttr_OnHASHCHANGE
    on_input = <unsigned int> TidyAttr_OnINPUT
    on_invalid = <unsigned int> TidyAttr_OnINVALID
    on_keydown = <unsigned int> TidyAttr_OnKEYDOWN
    on_keypress = <unsigned int> TidyAttr_OnKEYPRESS
    on_keyup = <unsigned int> TidyAttr_OnKEYUP
    on_load = <unsigned int> TidyAttr_OnLOAD
    on_loadeddata = <unsigned int> TidyAttr_OnLOADEDDATA
    on_loadedmetadata = <unsigned int> TidyAttr_OnLOADEDMETADATA
    on_loadstart = <unsigned int> TidyAttr_OnLOADSTART
    on_message = <unsigned int> TidyAttr_OnMESSAGE
    on_mousedown = <unsigned int> TidyAttr_OnMOUSEDOWN
    on_mousemove = <unsigned int> TidyAttr_OnMOUSEMOVE
    on_mouseout = <unsigned int> TidyAttr_OnMOUSEOUT
    on_mouseover = <unsigned int> TidyAttr_OnMOUSEOVER
    on_mouseup = <unsigned int> TidyAttr_OnMOUSEUP
    on_mousewheel = <unsigned int> TidyAttr_OnMOUSEWHEEL
    on_offline = <unsigned int> TidyAttr_OnOFFLINE
    on_online = <unsigned int> TidyAttr_OnONLINE
    on_pagehide = <unsigned int> TidyAttr_OnPAGEHIDE
    on_pageshow = <unsigned int> TidyAttr_OnPAGESHOW
    on_pause = <unsigned int> TidyAttr_OnPAUSE
    on_play = <unsigned int> TidyAttr_OnPLAY
    on_playing = <unsigned int> TidyAttr_OnPLAYING
    on_popstate = <unsigned int> TidyAttr_OnPOPSTATE
    on_progress = <unsigned int> TidyAttr_OnPROGRESS
    on_ratechange = <unsigned int> TidyAttr_OnRATECHANGE
    on_readystatechange = <unsigned int> TidyAttr_OnREADYSTATECHANGE
    on_redo = <unsigned int> TidyAttr_OnREDO
    on_reset = <unsigned int> TidyAttr_OnRESET
    on_resize = <unsigned int> TidyAttr_OnRESIZE
    on_rowenter = <unsigned int> TidyAttr_OnROWENTER
    on_rowexit = <unsigned int> TidyAttr_OnROWEXIT
    on_scroll = <unsigned int> TidyAttr_OnSCROLL
    on_seeked = <unsigned int> TidyAttr_OnSEEKED
    on_seeking = <unsigned int> TidyAttr_OnSEEKING
    on_select = <unsigned int> TidyAttr_OnSELECT
    on_show = <unsigned int> TidyAttr_OnSHOW
    on_stalled = <unsigned int> TidyAttr_OnSTALLED
    on_storage = <unsigned int> TidyAttr_OnSTORAGE
    on_submit = <unsigned int> TidyAttr_OnSUBMIT
    on_suspend = <unsigned int> TidyAttr_OnSUSPEND
    on_timeupdate = <unsigned int> TidyAttr_OnTIMEUPDATE
    on_undo = <unsigned int> TidyAttr_OnUNDO
    on_unload = <unsigned int> TidyAttr_OnUNLOAD
    on_volumechange = <unsigned int> TidyAttr_OnVOLUMECHANGE
    on_waiting = <unsigned int> TidyAttr_OnWAITING
    pattern = <unsigned int> TidyAttr_PATTERN
    placeholder = <unsigned int> TidyAttr_PLACEHOLDER
    poster = <unsigned int> TidyAttr_POSTER
    prefix = <unsigned int> TidyAttr_PREFIX
    preload = <unsigned int> TidyAttr_PRELOAD
    preserveaspectratio = <unsigned int> TidyAttr_PRESERVEASPECTRATIO
    profile = <unsigned int> TidyAttr_PROFILE
    prompt = <unsigned int> TidyAttr_PROMPT
    property = <unsigned int> TidyAttr_PROPERTY
    pubdate = <unsigned int> TidyAttr_PUBDATE
    radiogroup = <unsigned int> TidyAttr_RADIOGROUP
    rbspan = <unsigned int> TidyAttr_RBSPAN
    readonly = <unsigned int> TidyAttr_READONLY
    rel = <unsigned int> TidyAttr_REL
    required = <unsigned int> TidyAttr_REQUIRED
    resource = <unsigned int> TidyAttr_RESOURCE
    rev = <unsigned int> TidyAttr_REV
    reversed = <unsigned int> TidyAttr_REVERSED
    rightmargin = <unsigned int> TidyAttr_RIGHTMARGIN
    role = <unsigned int> TidyAttr_ROLE
    rows = <unsigned int> TidyAttr_ROWS
    rowspan = <unsigned int> TidyAttr_ROWSPAN
    rules = <unsigned int> TidyAttr_RULES
    sandbox = <unsigned int> TidyAttr_SANDBOX
    scheme = <unsigned int> TidyAttr_SCHEME
    scope = <unsigned int> TidyAttr_SCOPE
    scoped = <unsigned int> TidyAttr_SCOPED
    scrolling = <unsigned int> TidyAttr_SCROLLING
    sdaform = <unsigned int> TidyAttr_SDAFORM
    sdapref = <unsigned int> TidyAttr_SDAPREF
    sdasuff = <unsigned int> TidyAttr_SDASUFF
    seamless = <unsigned int> TidyAttr_SEAMLESS
    selected = <unsigned int> TidyAttr_SELECTED
    shape = <unsigned int> TidyAttr_SHAPE
    showgrid = <unsigned int> TidyAttr_SHOWGRID
    showgridx = <unsigned int> TidyAttr_SHOWGRIDX
    showgridy = <unsigned int> TidyAttr_SHOWGRIDY
    size = <unsigned int> TidyAttr_SIZE
    sizes = <unsigned int> TidyAttr_SIZES
    span = <unsigned int> TidyAttr_SPAN
    spellcheck = <unsigned int> TidyAttr_SPELLCHECK
    src = <unsigned int> TidyAttr_SRC
    srcdoc = <unsigned int> TidyAttr_SRCDOC
    srclang = <unsigned int> TidyAttr_SRCLANG
    srcset = <unsigned int> TidyAttr_SRCSET
    standby = <unsigned int> TidyAttr_STANDBY
    start = <unsigned int> TidyAttr_START
    step = <unsigned int> TidyAttr_STEP
    style = <unsigned int> TidyAttr_STYLE
    summary = <unsigned int> TidyAttr_SUMMARY
    tabindex = <unsigned int> TidyAttr_TABINDEX
    target = <unsigned int> TidyAttr_TARGET
    text = <unsigned int> TidyAttr_TEXT
    title = <unsigned int> TidyAttr_TITLE
    topmargin = <unsigned int> TidyAttr_TOPMARGIN
    translate = <unsigned int> TidyAttr_TRANSLATE
    type = <unsigned int> TidyAttr_TYPE
    typeof = <unsigned int> TidyAttr_TYPEOF
    unknown = <unsigned int> TidyAttr_UNKNOWN
    urn = <unsigned int> TidyAttr_URN
    usemap = <unsigned int> TidyAttr_USEMAP
    valign = <unsigned int> TidyAttr_VALIGN
    value = <unsigned int> TidyAttr_VALUE
    valuetype = <unsigned int> TidyAttr_VALUETYPE
    version = <unsigned int> TidyAttr_VERSION
    viewbox = <unsigned int> TidyAttr_VIEWBOX
    vlink = <unsigned int> TidyAttr_VLINK
    vocab = <unsigned int> TidyAttr_VOCAB
    vspace = <unsigned int> TidyAttr_VSPACE
    width = <unsigned int> TidyAttr_WIDTH
    wrap = <unsigned int> TidyAttr_WRAP
    x = <unsigned int> TidyAttr_X
    xmlns = <unsigned int> TidyAttr_XMLNS
    xmlnsxlink = <unsigned int> TidyAttr_XMLNSXLINK
    xml_lang = <unsigned int> TidyAttr_XML_LANG
    xml_space = <unsigned int> TidyAttr_XML_SPACE
    y = <unsigned int> TidyAttr_Y
    zoomandpan = <unsigned int> TidyAttr_ZOOMANDPAN


class _AttrSortStrategy(IntEnum):
    __name__ =  __qualname__ = 'AttrSortStrategy'
    for_name = staticmethod(attr_sort_strategy_for_name)

    alpha = <unsigned int> TidySortAttrAlpha
    none = <unsigned int> TidySortAttrNone


class _ConfigCategory(IntEnum):
    __name__ =  __qualname__ = 'ConfigCategory'
    for_name = staticmethod(config_category_for_name)

    diagnostics = <unsigned int> TidyDiagnostics
    display = <unsigned int> TidyDisplay
    document_io = <unsigned int> TidyDocumentIO
    encoding = <unsigned int> TidyEncoding
    file_io = <unsigned int> TidyFileIO
    internal_category = <unsigned int> TidyInternalCategory
    markup_cleanup = <unsigned int> TidyMarkupCleanup
    markup_entities = <unsigned int> TidyMarkupEntities
    markup_repair = <unsigned int> TidyMarkupRepair
    markup_teach = <unsigned int> TidyMarkupTeach
    markup_x_form = <unsigned int> TidyMarkupXForm
    pretty_print = <unsigned int> TidyPrettyPrint
    unknown_category = <unsigned int> TidyUnknownCategory


class _DoctypeModes(IntEnum):
    __name__ =  __qualname__ = 'DoctypeModes'
    for_name = staticmethod(doctype_modes_for_name)

    auto = <unsigned int> TidyDoctypeAuto
    html5 = <unsigned int> TidyDoctypeHtml5
    loose = <unsigned int> TidyDoctypeLoose
    omit = <unsigned int> TidyDoctypeOmit
    strict = <unsigned int> TidyDoctypeStrict
    user = <unsigned int> TidyDoctypeUser


class _DupAttrModes(IntEnum):
    __name__ =  __qualname__ = 'DupAttrModes'
    for_name = staticmethod(dup_attr_modes_for_name)

    keep_first = <unsigned int> TidyKeepFirst
    keep_last = <unsigned int> TidyKeepLast


class _EncodingOptions(IntEnum):
    __name__ =  __qualname__ = 'EncodingOptions'
    for_name = staticmethod(encoding_options_for_name)

    ascii = <unsigned int> TidyEncAscii
    big5 = <unsigned int> TidyEncBig5
    ibm858 = <unsigned int> TidyEncIbm858
    iso2022 = <unsigned int> TidyEncIso2022
    latin0 = <unsigned int> TidyEncLatin0
    latin1 = <unsigned int> TidyEncLatin1
    mac = <unsigned int> TidyEncMac
    raw = <unsigned int> TidyEncRaw
    shiftjis = <unsigned int> TidyEncShiftjis
    utf16 = <unsigned int> TidyEncUtf16
    utf16be = <unsigned int> TidyEncUtf16be
    utf16le = <unsigned int> TidyEncUtf16le
    utf8 = <unsigned int> TidyEncUtf8
    win1252 = <unsigned int> TidyEncWin1252


class _FormatParameterType(IntEnum):
    __name__ =  __qualname__ = 'FormatParameterType'
    for_name = staticmethod(format_parameter_type_for_name)

    double = <unsigned int> tidyFormatType_DOUBLE
    int = <unsigned int> tidyFormatType_INT
    string = <unsigned int> tidyFormatType_STRING
    uint = <unsigned int> tidyFormatType_UINT
    unknown = <unsigned int> tidyFormatType_UNKNOWN


class _LineEnding(IntEnum):
    __name__ =  __qualname__ = 'LineEnding'
    for_name = staticmethod(line_ending_for_name)

    cr = <unsigned int> TidyCR
    crlf = <unsigned int> TidyCRLF
    lf = <unsigned int> TidyLF


class _NodeType(IntEnum):
    __name__ =  __qualname__ = 'NodeType'
    for_name = staticmethod(node_type_for_name)

    asp = <unsigned int> TidyNode_Asp
    cdata = <unsigned int> TidyNode_CDATA
    comment = <unsigned int> TidyNode_Comment
    doc_type = <unsigned int> TidyNode_DocType
    end = <unsigned int> TidyNode_End
    jste = <unsigned int> TidyNode_Jste
    php = <unsigned int> TidyNode_Php
    proc_ins = <unsigned int> TidyNode_ProcIns
    root = <unsigned int> TidyNode_Root
    section = <unsigned int> TidyNode_Section
    start = <unsigned int> TidyNode_Start
    start_end = <unsigned int> TidyNode_StartEnd
    text = <unsigned int> TidyNode_Text
    xml_decl = <unsigned int> TidyNode_XmlDecl


class _OptionId(IntEnum):
    __name__ =  __qualname__ = 'OptionId'
    for_name = staticmethod(option_id_for_name)

    n_tidy_options = <unsigned int> N_TIDY_OPTIONS
    accessibility_check_level = <unsigned int> TidyAccessibilityCheckLevel
    alt_text = <unsigned int> TidyAltText
    anchor_as_name = <unsigned int> TidyAnchorAsName
    ascii_chars = <unsigned int> TidyAsciiChars
    block_tags = <unsigned int> TidyBlockTags
    body_only = <unsigned int> TidyBodyOnly
    break_before_br = <unsigned int> TidyBreakBeforeBR
    css_prefix = <unsigned int> TidyCSSPrefix
    char_encoding = <unsigned int> TidyCharEncoding
    coerce_end_tags = <unsigned int> TidyCoerceEndTags
    custom_tags = <unsigned int> TidyCustomTags
    decorate_inferred_ul = <unsigned int> TidyDecorateInferredUL
    doctype = <unsigned int> TidyDoctype
    doctype_mode = <unsigned int> TidyDoctypeMode
    drop_empty_elems = <unsigned int> TidyDropEmptyElems
    drop_empty_paras = <unsigned int> TidyDropEmptyParas
    drop_prop_attrs = <unsigned int> TidyDropPropAttrs
    duplicate_attrs = <unsigned int> TidyDuplicateAttrs
    emacs = <unsigned int> TidyEmacs
    emacs_file = <unsigned int> TidyEmacsFile
    empty_tags = <unsigned int> TidyEmptyTags
    enclose_block_text = <unsigned int> TidyEncloseBlockText
    enclose_body_text = <unsigned int> TidyEncloseBodyText
    err_file = <unsigned int> TidyErrFile
    escape_cdata = <unsigned int> TidyEscapeCdata
    escape_scripts = <unsigned int> TidyEscapeScripts
    fix_backslash = <unsigned int> TidyFixBackslash
    fix_comments = <unsigned int> TidyFixComments
    fix_uri = <unsigned int> TidyFixUri
    force_output = <unsigned int> TidyForceOutput
    g_doc_clean = <unsigned int> TidyGDocClean
    hide_comments = <unsigned int> TidyHideComments
    html_out = <unsigned int> TidyHtmlOut
    in_char_encoding = <unsigned int> TidyInCharEncoding
    indent_attributes = <unsigned int> TidyIndentAttributes
    indent_cdata = <unsigned int> TidyIndentCdata
    indent_content = <unsigned int> TidyIndentContent
    indent_spaces = <unsigned int> TidyIndentSpaces
    inline_tags = <unsigned int> TidyInlineTags
    join_classes = <unsigned int> TidyJoinClasses
    join_styles = <unsigned int> TidyJoinStyles
    keep_file_times = <unsigned int> TidyKeepFileTimes
    keep_tabs = <unsigned int> TidyKeepTabs
    literal_attribs = <unsigned int> TidyLiteralAttribs
    logical_emphasis = <unsigned int> TidyLogicalEmphasis
    lower_literals = <unsigned int> TidyLowerLiterals
    make_bare = <unsigned int> TidyMakeBare
    make_clean = <unsigned int> TidyMakeClean
    mark = <unsigned int> TidyMark
    merge_divs = <unsigned int> TidyMergeDivs
    merge_emphasis = <unsigned int> TidyMergeEmphasis
    merge_spans = <unsigned int> TidyMergeSpans
    meta_charset = <unsigned int> TidyMetaCharset
    mute_reports = <unsigned int> TidyMuteReports
    mute_show = <unsigned int> TidyMuteShow
    ncr = <unsigned int> TidyNCR
    newline = <unsigned int> TidyNewline
    num_entities = <unsigned int> TidyNumEntities
    omit_optional_tags = <unsigned int> TidyOmitOptionalTags
    out_char_encoding = <unsigned int> TidyOutCharEncoding
    out_file = <unsigned int> TidyOutFile
    output_bom = <unsigned int> TidyOutputBOM
    p_print_tabs = <unsigned int> TidyPPrintTabs
    pre_tags = <unsigned int> TidyPreTags
    preserve_entities = <unsigned int> TidyPreserveEntities
    priority_attributes = <unsigned int> TidyPriorityAttributes
    punct_wrap = <unsigned int> TidyPunctWrap
    quiet = <unsigned int> TidyQuiet
    quote_ampersand = <unsigned int> TidyQuoteAmpersand
    quote_marks = <unsigned int> TidyQuoteMarks
    quote_nbsp = <unsigned int> TidyQuoteNbsp
    replace_color = <unsigned int> TidyReplaceColor
    show_errors = <unsigned int> TidyShowErrors
    show_info = <unsigned int> TidyShowInfo
    show_markup = <unsigned int> TidyShowMarkup
    show_meta_change = <unsigned int> TidyShowMetaChange
    show_warnings = <unsigned int> TidyShowWarnings
    skip_nested = <unsigned int> TidySkipNested
    sort_attributes = <unsigned int> TidySortAttributes
    strict_tags_attr = <unsigned int> TidyStrictTagsAttr
    style_tags = <unsigned int> TidyStyleTags
    tab_size = <unsigned int> TidyTabSize
    unknown_option = <unsigned int> TidyUnknownOption
    upper_case_attrs = <unsigned int> TidyUpperCaseAttrs
    upper_case_tags = <unsigned int> TidyUpperCaseTags
    use_custom_tags = <unsigned int> TidyUseCustomTags
    vert_space = <unsigned int> TidyVertSpace
    warn_prop_attrs = <unsigned int> TidyWarnPropAttrs
    word2000 = <unsigned int> TidyWord2000
    wrap_asp = <unsigned int> TidyWrapAsp
    wrap_att_vals = <unsigned int> TidyWrapAttVals
    wrap_jste = <unsigned int> TidyWrapJste
    wrap_len = <unsigned int> TidyWrapLen
    wrap_php = <unsigned int> TidyWrapPhp
    wrap_scriptlets = <unsigned int> TidyWrapScriptlets
    wrap_section = <unsigned int> TidyWrapSection
    write_back = <unsigned int> TidyWriteBack
    xhtml_out = <unsigned int> TidyXhtmlOut
    xml_decl = <unsigned int> TidyXmlDecl
    xml_out = <unsigned int> TidyXmlOut
    xml_p_is = <unsigned int> TidyXmlPIs
    xml_space = <unsigned int> TidyXmlSpace
    xml_tags = <unsigned int> TidyXmlTags


class _OptionType(IntEnum):
    __name__ =  __qualname__ = 'OptionType'
    for_name = staticmethod(option_type_for_name)

    boolean = <unsigned int> TidyBoolean
    integer = <unsigned int> TidyInteger
    string = <unsigned int> TidyString


class _ReportLevel(IntEnum):
    __name__ =  __qualname__ = 'ReportLevel'
    for_name = staticmethod(report_level_for_name)

    access = <unsigned int> TidyAccess
    bad_document = <unsigned int> TidyBadDocument
    config = <unsigned int> TidyConfig
    dialogue_doc = <unsigned int> TidyDialogueDoc
    dialogue_footnote = <unsigned int> TidyDialogueFootnote
    dialogue_info = <unsigned int> TidyDialogueInfo
    dialogue_summary = <unsigned int> TidyDialogueSummary
    error = <unsigned int> TidyError
    fatal = <unsigned int> TidyFatal
    info = <unsigned int> TidyInfo
    warning = <unsigned int> TidyWarning


class _Strings(IntEnum):
    __name__ =  __qualname__ = 'Strings'
    for_name = staticmethod(strings_for_name)

    added_missing_charset = <unsigned int> ADDED_MISSING_CHARSET
    anchor_not_unique = <unsigned int> ANCHOR_NOT_UNIQUE
    apos_undefined = <unsigned int> APOS_UNDEFINED
    applet_missing_alt = <unsigned int> APPLET_MISSING_ALT
    area_missing_alt = <unsigned int> AREA_MISSING_ALT
    ascii_requires_description = <unsigned int> ASCII_REQUIRES_DESCRIPTION
    associate_labels_explicitly = <unsigned int> ASSOCIATE_LABELS_EXPLICITLY
    associate_labels_explicitly_for = <unsigned int> ASSOCIATE_LABELS_EXPLICITLY_FOR
    associate_labels_explicitly_id = <unsigned int> ASSOCIATE_LABELS_EXPLICITLY_ID
    attribute_is_not_allowed = <unsigned int> ATTRIBUTE_IS_NOT_ALLOWED
    attribute_value_replaced = <unsigned int> ATTRIBUTE_VALUE_REPLACED
    attr_value_not_lcase = <unsigned int> ATTR_VALUE_NOT_LCASE
    audio_missing_text_aiff = <unsigned int> AUDIO_MISSING_TEXT_AIFF
    audio_missing_text_au = <unsigned int> AUDIO_MISSING_TEXT_AU
    audio_missing_text_ra = <unsigned int> AUDIO_MISSING_TEXT_RA
    audio_missing_text_rm = <unsigned int> AUDIO_MISSING_TEXT_RM
    audio_missing_text_snd = <unsigned int> AUDIO_MISSING_TEXT_SND
    audio_missing_text_wav = <unsigned int> AUDIO_MISSING_TEXT_WAV
    backslash_in_uri = <unsigned int> BACKSLASH_IN_URI
    bad_attribute_value = <unsigned int> BAD_ATTRIBUTE_VALUE
    bad_attribute_value_replaced = <unsigned int> BAD_ATTRIBUTE_VALUE_REPLACED
    bad_cdata_content = <unsigned int> BAD_CDATA_CONTENT
    bad_summary_html5 = <unsigned int> BAD_SUMMARY_HTML5
    bad_surrogate_lead = <unsigned int> BAD_SURROGATE_LEAD
    bad_surrogate_pair = <unsigned int> BAD_SURROGATE_PAIR
    bad_surrogate_tail = <unsigned int> BAD_SURROGATE_TAIL
    cant_be_nested = <unsigned int> CANT_BE_NESTED
    coerce_to_endtag = <unsigned int> COERCE_TO_ENDTAG
    color_contrast_active_link = <unsigned int> COLOR_CONTRAST_ACTIVE_LINK
    color_contrast_link = <unsigned int> COLOR_CONTRAST_LINK
    color_contrast_text = <unsigned int> COLOR_CONTRAST_TEXT
    color_contrast_visited_link = <unsigned int> COLOR_CONTRAST_VISITED_LINK
    content_after_body = <unsigned int> CONTENT_AFTER_BODY
    custom_tag_detected = <unsigned int> CUSTOM_TAG_DETECTED
    data_table_missing_headers = <unsigned int> DATA_TABLE_MISSING_HEADERS
    data_table_missing_headers_column = <unsigned int> DATA_TABLE_MISSING_HEADERS_COLUMN
    data_table_missing_headers_row = <unsigned int> DATA_TABLE_MISSING_HEADERS_ROW
    data_table_require_markup_column_headers = <unsigned int> DATA_TABLE_REQUIRE_MARKUP_COLUMN_HEADERS
    data_table_require_markup_row_headers = <unsigned int> DATA_TABLE_REQUIRE_MARKUP_ROW_HEADERS
    discarding_unexpected = <unsigned int> DISCARDING_UNEXPECTED
    doctype_after_tags = <unsigned int> DOCTYPE_AFTER_TAGS
    doctype_missing = <unsigned int> DOCTYPE_MISSING
    duplicate_frameset = <unsigned int> DUPLICATE_FRAMESET
    element_not_empty = <unsigned int> ELEMENT_NOT_EMPTY
    element_vers_mismatch_error = <unsigned int> ELEMENT_VERS_MISMATCH_ERROR
    element_vers_mismatch_warn = <unsigned int> ELEMENT_VERS_MISMATCH_WARN
    encoding_mismatch = <unsigned int> ENCODING_MISMATCH
    ensure_programmatic_objects_accessible_applet = <unsigned int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_APPLET
    ensure_programmatic_objects_accessible_embed = <unsigned int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_EMBED
    ensure_programmatic_objects_accessible_object = <unsigned int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_OBJECT
    ensure_programmatic_objects_accessible_script = <unsigned int> ENSURE_PROGRAMMATIC_OBJECTS_ACCESSIBLE_SCRIPT
    escaped_illegal_uri = <unsigned int> ESCAPED_ILLEGAL_URI
    file_cant_open = <unsigned int> FILE_CANT_OPEN
    file_cant_open_cfg = <unsigned int> FILE_CANT_OPEN_CFG
    file_not_file = <unsigned int> FILE_NOT_FILE
    fixed_backslash = <unsigned int> FIXED_BACKSLASH
    footnote_trim_empty_element = <unsigned int> FOOTNOTE_TRIM_EMPTY_ELEMENT
    found_style_in_body = <unsigned int> FOUND_STYLE_IN_BODY
    frame_missing_longdesc = <unsigned int> FRAME_MISSING_LONGDESC
    frame_missing_noframes = <unsigned int> FRAME_MISSING_NOFRAMES
    frame_missing_title = <unsigned int> FRAME_MISSING_TITLE
    frame_src_invalid = <unsigned int> FRAME_SRC_INVALID
    frame_title_invalid_null = <unsigned int> FRAME_TITLE_INVALID_NULL
    frame_title_invalid_spaces = <unsigned int> FRAME_TITLE_INVALID_SPACES
    headers_improperly_nested = <unsigned int> HEADERS_IMPROPERLY_NESTED
    header_used_format_text = <unsigned int> HEADER_USED_FORMAT_TEXT
    id_name_mismatch = <unsigned int> ID_NAME_MISMATCH
    illegal_nesting = <unsigned int> ILLEGAL_NESTING
    illegal_uri_codepoint = <unsigned int> ILLEGAL_URI_CODEPOINT
    illegal_uri_reference = <unsigned int> ILLEGAL_URI_REFERENCE
    image_map_server_side_requires_conversion = <unsigned int> IMAGE_MAP_SERVER_SIDE_REQUIRES_CONVERSION
    img_alt_suspicious_filename = <unsigned int> IMG_ALT_SUSPICIOUS_FILENAME
    img_alt_suspicious_file_size = <unsigned int> IMG_ALT_SUSPICIOUS_FILE_SIZE
    img_alt_suspicious_placeholder = <unsigned int> IMG_ALT_SUSPICIOUS_PLACEHOLDER
    img_alt_suspicious_too_long = <unsigned int> IMG_ALT_SUSPICIOUS_TOO_LONG
    img_button_missing_alt = <unsigned int> IMG_BUTTON_MISSING_ALT
    img_map_client_missing_text_links = <unsigned int> IMG_MAP_CLIENT_MISSING_TEXT_LINKS
    img_map_server_requires_text_links = <unsigned int> IMG_MAP_SERVER_REQUIRES_TEXT_LINKS
    img_missing_alt = <unsigned int> IMG_MISSING_ALT
    img_missing_dlink = <unsigned int> IMG_MISSING_DLINK
    img_missing_longdesc = <unsigned int> IMG_MISSING_LONGDESC
    img_missing_longdesc_dlink = <unsigned int> IMG_MISSING_LONGDESC_DLINK
    information_not_conveyed_applet = <unsigned int> INFORMATION_NOT_CONVEYED_APPLET
    information_not_conveyed_image = <unsigned int> INFORMATION_NOT_CONVEYED_IMAGE
    information_not_conveyed_input = <unsigned int> INFORMATION_NOT_CONVEYED_INPUT
    information_not_conveyed_object = <unsigned int> INFORMATION_NOT_CONVEYED_OBJECT
    information_not_conveyed_script = <unsigned int> INFORMATION_NOT_CONVEYED_SCRIPT
    inserting_auto_attribute = <unsigned int> INSERTING_AUTO_ATTRIBUTE
    inserting_tag = <unsigned int> INSERTING_TAG
    invalid_attribute = <unsigned int> INVALID_ATTRIBUTE
    invalid_ncr = <unsigned int> INVALID_NCR
    invalid_sgml_chars = <unsigned int> INVALID_SGML_CHARS
    invalid_utf16 = <unsigned int> INVALID_UTF16
    invalid_utf8 = <unsigned int> INVALID_UTF8
    invalid_xml_id = <unsigned int> INVALID_XML_ID
    joining_attribute = <unsigned int> JOINING_ATTRIBUTE
    language_invalid = <unsigned int> LANGUAGE_INVALID
    language_not_identified = <unsigned int> LANGUAGE_NOT_IDENTIFIED
    layout_tables_linearize_properly = <unsigned int> LAYOUT_TABLES_LINEARIZE_PROPERLY
    layout_table_invalid_markup = <unsigned int> LAYOUT_TABLE_INVALID_MARKUP
    line_column_string = <unsigned int> LINE_COLUMN_STRING
    link_text_missing = <unsigned int> LINK_TEXT_MISSING
    link_text_not_meaningful = <unsigned int> LINK_TEXT_NOT_MEANINGFUL
    link_text_not_meaningful_click_here = <unsigned int> LINK_TEXT_NOT_MEANINGFUL_CLICK_HERE
    link_text_too_long = <unsigned int> LINK_TEXT_TOO_LONG
    list_usage_invalid_li = <unsigned int> LIST_USAGE_INVALID_LI
    list_usage_invalid_ol = <unsigned int> LIST_USAGE_INVALID_OL
    list_usage_invalid_ul = <unsigned int> LIST_USAGE_INVALID_UL
    malformed_comment = <unsigned int> MALFORMED_COMMENT
    malformed_comment_dropping = <unsigned int> MALFORMED_COMMENT_DROPPING
    malformed_comment_eos = <unsigned int> MALFORMED_COMMENT_EOS
    malformed_comment_warn = <unsigned int> MALFORMED_COMMENT_WARN
    malformed_doctype = <unsigned int> MALFORMED_DOCTYPE
    metadata_missing = <unsigned int> METADATA_MISSING
    metadata_missing_redirect_autorefresh = <unsigned int> METADATA_MISSING_REDIRECT_AUTOREFRESH
    mismatched_attribute_error = <unsigned int> MISMATCHED_ATTRIBUTE_ERROR
    mismatched_attribute_warn = <unsigned int> MISMATCHED_ATTRIBUTE_WARN
    missing_attribute = <unsigned int> MISSING_ATTRIBUTE
    missing_attr_value = <unsigned int> MISSING_ATTR_VALUE
    missing_doctype = <unsigned int> MISSING_DOCTYPE
    missing_endtag_before = <unsigned int> MISSING_ENDTAG_BEFORE
    missing_endtag_for = <unsigned int> MISSING_ENDTAG_FOR
    missing_endtag_optional = <unsigned int> MISSING_ENDTAG_OPTIONAL
    missing_imagemap = <unsigned int> MISSING_IMAGEMAP
    missing_quotemark = <unsigned int> MISSING_QUOTEMARK
    missing_quotemark_open = <unsigned int> MISSING_QUOTEMARK_OPEN
    missing_semicolon = <unsigned int> MISSING_SEMICOLON
    missing_semicolon_ncr = <unsigned int> MISSING_SEMICOLON_NCR
    missing_starttag = <unsigned int> MISSING_STARTTAG
    missing_title_element = <unsigned int> MISSING_TITLE_ELEMENT
    moved_style_to_head = <unsigned int> MOVED_STYLE_TO_HEAD
    multimedia_requires_text = <unsigned int> MULTIMEDIA_REQUIRES_TEXT
    nested_emphasis = <unsigned int> NESTED_EMPHASIS
    nested_quotation = <unsigned int> NESTED_QUOTATION
    newline_in_uri = <unsigned int> NEWLINE_IN_URI
    new_windows_require_warning_blank = <unsigned int> NEW_WINDOWS_REQUIRE_WARNING_BLANK
    new_windows_require_warning_new = <unsigned int> NEW_WINDOWS_REQUIRE_WARNING_NEW
    noframes_content = <unsigned int> NOFRAMES_CONTENT
    noframes_invalid_content = <unsigned int> NOFRAMES_INVALID_CONTENT
    noframes_invalid_link = <unsigned int> NOFRAMES_INVALID_LINK
    noframes_invalid_no_value = <unsigned int> NOFRAMES_INVALID_NO_VALUE
    non_matching_endtag = <unsigned int> NON_MATCHING_ENDTAG
    object_missing_alt = <unsigned int> OBJECT_MISSING_ALT
    obsolete_element = <unsigned int> OBSOLETE_ELEMENT
    option_removed = <unsigned int> OPTION_REMOVED
    option_removed_applied = <unsigned int> OPTION_REMOVED_APPLIED
    option_removed_unapplied = <unsigned int> OPTION_REMOVED_UNAPPLIED
    potential_header_bold = <unsigned int> POTENTIAL_HEADER_BOLD
    potential_header_italics = <unsigned int> POTENTIAL_HEADER_ITALICS
    potential_header_underline = <unsigned int> POTENTIAL_HEADER_UNDERLINE
    previous_location = <unsigned int> PREVIOUS_LOCATION
    programmatic_objects_require_testing_applet = <unsigned int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_APPLET
    programmatic_objects_require_testing_embed = <unsigned int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_EMBED
    programmatic_objects_require_testing_object = <unsigned int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_OBJECT
    programmatic_objects_require_testing_script = <unsigned int> PROGRAMMATIC_OBJECTS_REQUIRE_TESTING_SCRIPT
    proprietary_attribute = <unsigned int> PROPRIETARY_ATTRIBUTE
    proprietary_attr_value = <unsigned int> PROPRIETARY_ATTR_VALUE
    proprietary_element = <unsigned int> PROPRIETARY_ELEMENT
    removed_html5 = <unsigned int> REMOVED_HTML5
    remove_auto_redirect = <unsigned int> REMOVE_AUTO_REDIRECT
    remove_auto_refresh = <unsigned int> REMOVE_AUTO_REFRESH
    remove_blink_marquee = <unsigned int> REMOVE_BLINK_MARQUEE
    remove_flicker_animated_gif = <unsigned int> REMOVE_FLICKER_ANIMATED_GIF
    remove_flicker_applet = <unsigned int> REMOVE_FLICKER_APPLET
    remove_flicker_embed = <unsigned int> REMOVE_FLICKER_EMBED
    remove_flicker_object = <unsigned int> REMOVE_FLICKER_OBJECT
    remove_flicker_script = <unsigned int> REMOVE_FLICKER_SCRIPT
    repeated_attribute = <unsigned int> REPEATED_ATTRIBUTE
    replace_deprecated_html_applet = <unsigned int> REPLACE_DEPRECATED_HTML_APPLET
    replace_deprecated_html_basefont = <unsigned int> REPLACE_DEPRECATED_HTML_BASEFONT
    replace_deprecated_html_center = <unsigned int> REPLACE_DEPRECATED_HTML_CENTER
    replace_deprecated_html_dir = <unsigned int> REPLACE_DEPRECATED_HTML_DIR
    replace_deprecated_html_font = <unsigned int> REPLACE_DEPRECATED_HTML_FONT
    replace_deprecated_html_isindex = <unsigned int> REPLACE_DEPRECATED_HTML_ISINDEX
    replace_deprecated_html_menu = <unsigned int> REPLACE_DEPRECATED_HTML_MENU
    replace_deprecated_html_s = <unsigned int> REPLACE_DEPRECATED_HTML_S
    replace_deprecated_html_strike = <unsigned int> REPLACE_DEPRECATED_HTML_STRIKE
    replace_deprecated_html_u = <unsigned int> REPLACE_DEPRECATED_HTML_U
    replacing_element = <unsigned int> REPLACING_ELEMENT
    replacing_unex_element = <unsigned int> REPLACING_UNEX_ELEMENT
    report_message_first = <unsigned int> REPORT_MESSAGE_FIRST
    report_message_last = <unsigned int> REPORT_MESSAGE_LAST
    script_missing_noscript = <unsigned int> SCRIPT_MISSING_NOSCRIPT
    script_not_keyboard_accessible_on_click = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_CLICK
    script_not_keyboard_accessible_on_mouse_down = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_DOWN
    script_not_keyboard_accessible_on_mouse_move = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_MOVE
    script_not_keyboard_accessible_on_mouse_out = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_OUT
    script_not_keyboard_accessible_on_mouse_over = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_OVER
    script_not_keyboard_accessible_on_mouse_up = <unsigned int> SCRIPT_NOT_KEYBOARD_ACCESSIBLE_ON_MOUSE_UP
    skipover_ascii_art = <unsigned int> SKIPOVER_ASCII_ART
    space_preceding_xmldecl = <unsigned int> SPACE_PRECEDING_XMLDECL
    string_argument_bad = <unsigned int> STRING_ARGUMENT_BAD
    string_content_looks = <unsigned int> STRING_CONTENT_LOOKS
    string_discarding = <unsigned int> STRING_DISCARDING
    string_doctype_given = <unsigned int> STRING_DOCTYPE_GIVEN
    string_error_count = <unsigned int> STRING_ERROR_COUNT
    string_error_count_error = <unsigned int> STRING_ERROR_COUNT_ERROR
    string_error_count_warning = <unsigned int> STRING_ERROR_COUNT_WARNING
    string_hello_access = <unsigned int> STRING_HELLO_ACCESS
    string_html_proprietary = <unsigned int> STRING_HTML_PROPRIETARY
    string_missing_malformed = <unsigned int> STRING_MISSING_MALFORMED
    string_muting_type = <unsigned int> STRING_MUTING_TYPE
    string_needs_intervention = <unsigned int> STRING_NEEDS_INTERVENTION
    string_not_all_shown = <unsigned int> STRING_NOT_ALL_SHOWN
    string_no_errors = <unsigned int> STRING_NO_ERRORS
    string_no_sysid = <unsigned int> STRING_NO_SYSID
    string_plain_text = <unsigned int> STRING_PLAIN_TEXT
    string_replacing = <unsigned int> STRING_REPLACING
    string_specified = <unsigned int> STRING_SPECIFIED
    string_unknown_option = <unsigned int> STRING_UNKNOWN_OPTION
    string_xml_declaration = <unsigned int> STRING_XML_DECLARATION
    stylesheets_require_testing_link = <unsigned int> STYLESHEETS_REQUIRE_TESTING_LINK
    stylesheets_require_testing_style_attr = <unsigned int> STYLESHEETS_REQUIRE_TESTING_STYLE_ATTR
    stylesheets_require_testing_style_element = <unsigned int> STYLESHEETS_REQUIRE_TESTING_STYLE_ELEMENT
    style_sheet_control_presentation = <unsigned int> STYLE_SHEET_CONTROL_PRESENTATION
    suspected_missing_quote = <unsigned int> SUSPECTED_MISSING_QUOTE
    table_may_require_header_abbr = <unsigned int> TABLE_MAY_REQUIRE_HEADER_ABBR
    table_may_require_header_abbr_null = <unsigned int> TABLE_MAY_REQUIRE_HEADER_ABBR_NULL
    table_may_require_header_abbr_spaces = <unsigned int> TABLE_MAY_REQUIRE_HEADER_ABBR_SPACES
    table_missing_caption = <unsigned int> TABLE_MISSING_CAPTION
    table_missing_summary = <unsigned int> TABLE_MISSING_SUMMARY
    table_summary_invalid_null = <unsigned int> TABLE_SUMMARY_INVALID_NULL
    table_summary_invalid_placeholder = <unsigned int> TABLE_SUMMARY_INVALID_PLACEHOLDER
    table_summary_invalid_spaces = <unsigned int> TABLE_SUMMARY_INVALID_SPACES
    tag_not_allowed_in = <unsigned int> TAG_NOT_ALLOWED_IN
    tc_label_col = <unsigned int> TC_LABEL_COL
    tc_label_file = <unsigned int> TC_LABEL_FILE
    tc_label_lang = <unsigned int> TC_LABEL_LANG
    tc_label_levl = <unsigned int> TC_LABEL_LEVL
    tc_label_opt = <unsigned int> TC_LABEL_OPT
    tc_main_error_load_config = <unsigned int> TC_MAIN_ERROR_LOAD_CONFIG
    tc_opt_access = <unsigned int> TC_OPT_ACCESS
    tc_opt_ascii = <unsigned int> TC_OPT_ASCII
    tc_opt_ashtml = <unsigned int> TC_OPT_ASHTML
    tc_opt_asxml = <unsigned int> TC_OPT_ASXML
    tc_opt_bare = <unsigned int> TC_OPT_BARE
    tc_opt_big5 = <unsigned int> TC_OPT_BIG5
    tc_opt_clean = <unsigned int> TC_OPT_CLEAN
    tc_opt_config = <unsigned int> TC_OPT_CONFIG
    tc_opt_errors = <unsigned int> TC_OPT_ERRORS
    tc_opt_exp_cfg = <unsigned int> TC_OPT_EXP_CFG
    tc_opt_exp_def = <unsigned int> TC_OPT_EXP_DEF
    tc_opt_file = <unsigned int> TC_OPT_FILE
    tc_opt_gdoc = <unsigned int> TC_OPT_GDOC
    tc_opt_help = <unsigned int> TC_OPT_HELP
    tc_opt_helpcfg = <unsigned int> TC_OPT_HELPCFG
    tc_opt_helpenv = <unsigned int> TC_OPT_HELPENV
    tc_opt_helpopt = <unsigned int> TC_OPT_HELPOPT
    tc_opt_ibm858 = <unsigned int> TC_OPT_IBM858
    tc_opt_indent = <unsigned int> TC_OPT_INDENT
    tc_opt_iso2022 = <unsigned int> TC_OPT_ISO2022
    tc_opt_language = <unsigned int> TC_OPT_LANGUAGE
    tc_opt_latin0 = <unsigned int> TC_OPT_LATIN0
    tc_opt_latin1 = <unsigned int> TC_OPT_LATIN1
    tc_opt_mac = <unsigned int> TC_OPT_MAC
    tc_opt_modify = <unsigned int> TC_OPT_MODIFY
    tc_opt_numeric = <unsigned int> TC_OPT_NUMERIC
    tc_opt_omit = <unsigned int> TC_OPT_OMIT
    tc_opt_output = <unsigned int> TC_OPT_OUTPUT
    tc_opt_quiet = <unsigned int> TC_OPT_QUIET
    tc_opt_raw = <unsigned int> TC_OPT_RAW
    tc_opt_shiftjis = <unsigned int> TC_OPT_SHIFTJIS
    tc_opt_showcfg = <unsigned int> TC_OPT_SHOWCFG
    tc_opt_upper = <unsigned int> TC_OPT_UPPER
    tc_opt_utf16 = <unsigned int> TC_OPT_UTF16
    tc_opt_utf16_be = <unsigned int> TC_OPT_UTF16BE
    tc_opt_utf16_le = <unsigned int> TC_OPT_UTF16LE
    tc_opt_utf8 = <unsigned int> TC_OPT_UTF8
    tc_opt_version = <unsigned int> TC_OPT_VERSION
    tc_opt_win1252 = <unsigned int> TC_OPT_WIN1252
    tc_opt_wrap = <unsigned int> TC_OPT_WRAP
    tc_opt_xml = <unsigned int> TC_OPT_XML
    tc_opt_xmlcfg = <unsigned int> TC_OPT_XMLCFG
    tc_opt_xmlerrs = <unsigned int> TC_OPT_XMLERRS
    tc_opt_xmlhelp = <unsigned int> TC_OPT_XMLHELP
    tc_opt_xmlopts = <unsigned int> TC_OPT_XMLOPTS
    tc_opt_xmlstrg = <unsigned int> TC_OPT_XMLSTRG
    tc_string_char_encoding = <unsigned int> TC_STRING_CHAR_ENCODING
    tc_string_conf_header = <unsigned int> TC_STRING_CONF_HEADER
    tc_string_conf_name = <unsigned int> TC_STRING_CONF_NAME
    tc_string_conf_note = <unsigned int> TC_STRING_CONF_NOTE
    tc_string_conf_type = <unsigned int> TC_STRING_CONF_TYPE
    tc_string_conf_value = <unsigned int> TC_STRING_CONF_VALUE
    tc_string_fatal_error = <unsigned int> TC_STRING_FATAL_ERROR
    tc_string_file_manip = <unsigned int> TC_STRING_FILE_MANIP
    tc_string_lang_must_specify = <unsigned int> TC_STRING_LANG_MUST_SPECIFY
    tc_string_lang_not_found = <unsigned int> TC_STRING_LANG_NOT_FOUND
    tc_string_misc = <unsigned int> TC_STRING_MISC
    tc_string_must_specify = <unsigned int> TC_STRING_MUST_SPECIFY
    tc_string_opt_not_documented = <unsigned int> TC_STRING_OPT_NOT_DOCUMENTED
    tc_string_out_of_memory = <unsigned int> TC_STRING_OUT_OF_MEMORY
    tc_string_process_directives = <unsigned int> TC_STRING_PROCESS_DIRECTIVES
    tc_string_unknown_option = <unsigned int> TC_STRING_UNKNOWN_OPTION
    tc_string_unknown_option_b = <unsigned int> TC_STRING_UNKNOWN_OPTION_B
    tc_string_vers_a = <unsigned int> TC_STRING_VERS_A
    tc_string_vers_b = <unsigned int> TC_STRING_VERS_B
    tc_string_xml = <unsigned int> TC_STRING_XML
    tc_txt_help_1 = <unsigned int> TC_TXT_HELP_1
    tc_txt_help_2_a = <unsigned int> TC_TXT_HELP_2A
    tc_txt_help_2_b = <unsigned int> TC_TXT_HELP_2B
    tc_txt_help_3 = <unsigned int> TC_TXT_HELP_3
    tc_txt_help_3_a = <unsigned int> TC_TXT_HELP_3A
    tc_txt_help_config = <unsigned int> TC_TXT_HELP_CONFIG
    tc_txt_help_config_allw = <unsigned int> TC_TXT_HELP_CONFIG_ALLW
    tc_txt_help_config_name = <unsigned int> TC_TXT_HELP_CONFIG_NAME
    tc_txt_help_config_type = <unsigned int> TC_TXT_HELP_CONFIG_TYPE
    tc_txt_help_env_1 = <unsigned int> TC_TXT_HELP_ENV_1
    tc_txt_help_env_1_a = <unsigned int> TC_TXT_HELP_ENV_1A
    tc_txt_help_env_1_b = <unsigned int> TC_TXT_HELP_ENV_1B
    tc_txt_help_env_1_c = <unsigned int> TC_TXT_HELP_ENV_1C
    tc_txt_help_lang_1 = <unsigned int> TC_TXT_HELP_LANG_1
    tc_txt_help_lang_2 = <unsigned int> TC_TXT_HELP_LANG_2
    tc_txt_help_lang_3 = <unsigned int> TC_TXT_HELP_LANG_3
    text_access_advice1 = <unsigned int> TEXT_ACCESS_ADVICE1
    text_access_advice2 = <unsigned int> TEXT_ACCESS_ADVICE2
    text_bad_form = <unsigned int> TEXT_BAD_FORM
    text_bad_main = <unsigned int> TEXT_BAD_MAIN
    text_equivalents_require_updating_applet = <unsigned int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_APPLET
    text_equivalents_require_updating_object = <unsigned int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_OBJECT
    text_equivalents_require_updating_script = <unsigned int> TEXT_EQUIVALENTS_REQUIRE_UPDATING_SCRIPT
    text_general_info = <unsigned int> TEXT_GENERAL_INFO
    text_general_info_plea = <unsigned int> TEXT_GENERAL_INFO_PLEA
    text_html_t_algorithm = <unsigned int> TEXT_HTML_T_ALGORITHM
    text_invalid_uri = <unsigned int> TEXT_INVALID_URI
    text_invalid_utf16 = <unsigned int> TEXT_INVALID_UTF16
    text_invalid_utf8 = <unsigned int> TEXT_INVALID_UTF8
    text_m_image_alt = <unsigned int> TEXT_M_IMAGE_ALT
    text_m_image_map = <unsigned int> TEXT_M_IMAGE_MAP
    text_m_link_alt = <unsigned int> TEXT_M_LINK_ALT
    text_m_summary = <unsigned int> TEXT_M_SUMMARY
    text_sgml_chars = <unsigned int> TEXT_SGML_CHARS
    text_using_body = <unsigned int> TEXT_USING_BODY
    text_using_font = <unsigned int> TEXT_USING_FONT
    text_using_frames = <unsigned int> TEXT_USING_FRAMES
    text_using_layer = <unsigned int> TEXT_USING_LAYER
    text_using_nobr = <unsigned int> TEXT_USING_NOBR
    text_using_spacer = <unsigned int> TEXT_USING_SPACER
    text_vendor_chars = <unsigned int> TEXT_VENDOR_CHARS
    text_windows_chars = <unsigned int> TEXT_WINDOWS_CHARS
    tidycustomblocklevel_string = <unsigned int> TIDYCUSTOMBLOCKLEVEL_STRING
    tidycustomempty_string = <unsigned int> TIDYCUSTOMEMPTY_STRING
    tidycustominline_string = <unsigned int> TIDYCUSTOMINLINE_STRING
    tidycustomno_string = <unsigned int> TIDYCUSTOMNO_STRING
    tidycustompre_string = <unsigned int> TIDYCUSTOMPRE_STRING
    tidystrings_first = <unsigned int> TIDYSTRINGS_FIRST
    tidystrings_last = <unsigned int> TIDYSTRINGS_LAST
    too_many_elements = <unsigned int> TOO_MANY_ELEMENTS
    too_many_elements_in = <unsigned int> TOO_MANY_ELEMENTS_IN
    trim_empty_element = <unsigned int> TRIM_EMPTY_ELEMENT
    unescaped_ampersand = <unsigned int> UNESCAPED_AMPERSAND
    unexpected_endtag = <unsigned int> UNEXPECTED_ENDTAG
    unexpected_endtag_err = <unsigned int> UNEXPECTED_ENDTAG_ERR
    unexpected_endtag_in = <unsigned int> UNEXPECTED_ENDTAG_IN
    unexpected_end_of_file = <unsigned int> UNEXPECTED_END_OF_FILE
    unexpected_end_of_file_attr = <unsigned int> UNEXPECTED_END_OF_FILE_ATTR
    unexpected_equalsign = <unsigned int> UNEXPECTED_EQUALSIGN
    unexpected_gt = <unsigned int> UNEXPECTED_GT
    unexpected_quotemark = <unsigned int> UNEXPECTED_QUOTEMARK
    unknown_element = <unsigned int> UNKNOWN_ELEMENT
    unknown_element_looks_custom = <unsigned int> UNKNOWN_ELEMENT_LOOKS_CUSTOM
    unknown_entity = <unsigned int> UNKNOWN_ENTITY
    using_br_inplace_of = <unsigned int> USING_BR_INPLACE_OF
    vendor_specific_chars = <unsigned int> VENDOR_SPECIFIC_CHARS
    white_in_uri = <unsigned int> WHITE_IN_URI
    xml_declaration_detected = <unsigned int> XML_DECLARATION_DETECTED
    xml_id_syntax = <unsigned int> XML_ID_SYNTAX


class _TagId(IntEnum):
    __name__ =  __qualname__ = 'TagId'
    for_name = staticmethod(tag_id_for_name)

    n_tidy_tags = <unsigned int> N_TIDY_TAGS
    a = <unsigned int> TidyTag_A
    abbr = <unsigned int> TidyTag_ABBR
    acronym = <unsigned int> TidyTag_ACRONYM
    address = <unsigned int> TidyTag_ADDRESS
    align = <unsigned int> TidyTag_ALIGN
    applet = <unsigned int> TidyTag_APPLET
    area = <unsigned int> TidyTag_AREA
    article = <unsigned int> TidyTag_ARTICLE
    aside = <unsigned int> TidyTag_ASIDE
    audio = <unsigned int> TidyTag_AUDIO
    b = <unsigned int> TidyTag_B
    base = <unsigned int> TidyTag_BASE
    basefont = <unsigned int> TidyTag_BASEFONT
    bdi = <unsigned int> TidyTag_BDI
    bdo = <unsigned int> TidyTag_BDO
    bgsound = <unsigned int> TidyTag_BGSOUND
    big = <unsigned int> TidyTag_BIG
    blink = <unsigned int> TidyTag_BLINK
    blockquote = <unsigned int> TidyTag_BLOCKQUOTE
    body = <unsigned int> TidyTag_BODY
    br = <unsigned int> TidyTag_BR
    button = <unsigned int> TidyTag_BUTTON
    canvas = <unsigned int> TidyTag_CANVAS
    caption = <unsigned int> TidyTag_CAPTION
    center = <unsigned int> TidyTag_CENTER
    cite = <unsigned int> TidyTag_CITE
    code = <unsigned int> TidyTag_CODE
    col = <unsigned int> TidyTag_COL
    colgroup = <unsigned int> TidyTag_COLGROUP
    command = <unsigned int> TidyTag_COMMAND
    comment = <unsigned int> TidyTag_COMMENT
    datalist = <unsigned int> TidyTag_DATALIST
    dd = <unsigned int> TidyTag_DD
    del_ = <unsigned int> TidyTag_DEL
    details = <unsigned int> TidyTag_DETAILS
    dfn = <unsigned int> TidyTag_DFN
    dialog = <unsigned int> TidyTag_DIALOG
    dir = <unsigned int> TidyTag_DIR
    div = <unsigned int> TidyTag_DIV
    dl = <unsigned int> TidyTag_DL
    dt = <unsigned int> TidyTag_DT
    em = <unsigned int> TidyTag_EM
    embed = <unsigned int> TidyTag_EMBED
    fieldset = <unsigned int> TidyTag_FIELDSET
    figcaption = <unsigned int> TidyTag_FIGCAPTION
    figure = <unsigned int> TidyTag_FIGURE
    font = <unsigned int> TidyTag_FONT
    footer = <unsigned int> TidyTag_FOOTER
    form = <unsigned int> TidyTag_FORM
    frame = <unsigned int> TidyTag_FRAME
    frameset = <unsigned int> TidyTag_FRAMESET
    h1 = <unsigned int> TidyTag_H1
    h2 = <unsigned int> TidyTag_H2
    h3 = <unsigned int> TidyTag_H3
    h4 = <unsigned int> TidyTag_H4
    h5 = <unsigned int> TidyTag_H5
    h6 = <unsigned int> TidyTag_H6
    head = <unsigned int> TidyTag_HEAD
    header = <unsigned int> TidyTag_HEADER
    hgroup = <unsigned int> TidyTag_HGROUP
    hr = <unsigned int> TidyTag_HR
    html = <unsigned int> TidyTag_HTML
    i = <unsigned int> TidyTag_I
    iframe = <unsigned int> TidyTag_IFRAME
    ilayer = <unsigned int> TidyTag_ILAYER
    img = <unsigned int> TidyTag_IMG
    input = <unsigned int> TidyTag_INPUT
    ins = <unsigned int> TidyTag_INS
    isindex = <unsigned int> TidyTag_ISINDEX
    kbd = <unsigned int> TidyTag_KBD
    keygen = <unsigned int> TidyTag_KEYGEN
    label = <unsigned int> TidyTag_LABEL
    layer = <unsigned int> TidyTag_LAYER
    legend = <unsigned int> TidyTag_LEGEND
    li = <unsigned int> TidyTag_LI
    link = <unsigned int> TidyTag_LINK
    listing = <unsigned int> TidyTag_LISTING
    main = <unsigned int> TidyTag_MAIN
    map = <unsigned int> TidyTag_MAP
    mark = <unsigned int> TidyTag_MARK
    marquee = <unsigned int> TidyTag_MARQUEE
    mathml = <unsigned int> TidyTag_MATHML
    menu = <unsigned int> TidyTag_MENU
    menuitem = <unsigned int> TidyTag_MENUITEM
    meta = <unsigned int> TidyTag_META
    meter = <unsigned int> TidyTag_METER
    multicol = <unsigned int> TidyTag_MULTICOL
    nav = <unsigned int> TidyTag_NAV
    nextid = <unsigned int> TidyTag_NEXTID
    nobr = <unsigned int> TidyTag_NOBR
    noembed = <unsigned int> TidyTag_NOEMBED
    noframes = <unsigned int> TidyTag_NOFRAMES
    nolayer = <unsigned int> TidyTag_NOLAYER
    nosave = <unsigned int> TidyTag_NOSAVE
    noscript = <unsigned int> TidyTag_NOSCRIPT
    object = <unsigned int> TidyTag_OBJECT
    ol = <unsigned int> TidyTag_OL
    optgroup = <unsigned int> TidyTag_OPTGROUP
    option = <unsigned int> TidyTag_OPTION
    output = <unsigned int> TidyTag_OUTPUT
    p = <unsigned int> TidyTag_P
    param = <unsigned int> TidyTag_PARAM
    picture = <unsigned int> TidyTag_PICTURE
    plaintext = <unsigned int> TidyTag_PLAINTEXT
    pre = <unsigned int> TidyTag_PRE
    progress = <unsigned int> TidyTag_PROGRESS
    q = <unsigned int> TidyTag_Q
    rb = <unsigned int> TidyTag_RB
    rbc = <unsigned int> TidyTag_RBC
    rp = <unsigned int> TidyTag_RP
    rt = <unsigned int> TidyTag_RT
    rtc = <unsigned int> TidyTag_RTC
    ruby = <unsigned int> TidyTag_RUBY
    s = <unsigned int> TidyTag_S
    samp = <unsigned int> TidyTag_SAMP
    script = <unsigned int> TidyTag_SCRIPT
    section = <unsigned int> TidyTag_SECTION
    select = <unsigned int> TidyTag_SELECT
    server = <unsigned int> TidyTag_SERVER
    servlet = <unsigned int> TidyTag_SERVLET
    small = <unsigned int> TidyTag_SMALL
    source = <unsigned int> TidyTag_SOURCE
    spacer = <unsigned int> TidyTag_SPACER
    span = <unsigned int> TidyTag_SPAN
    strike = <unsigned int> TidyTag_STRIKE
    strong = <unsigned int> TidyTag_STRONG
    style = <unsigned int> TidyTag_STYLE
    sub = <unsigned int> TidyTag_SUB
    summary = <unsigned int> TidyTag_SUMMARY
    sup = <unsigned int> TidyTag_SUP
    svg = <unsigned int> TidyTag_SVG
    table = <unsigned int> TidyTag_TABLE
    tbody = <unsigned int> TidyTag_TBODY
    td = <unsigned int> TidyTag_TD
    template = <unsigned int> TidyTag_TEMPLATE
    textarea = <unsigned int> TidyTag_TEXTAREA
    tfoot = <unsigned int> TidyTag_TFOOT
    th = <unsigned int> TidyTag_TH
    thead = <unsigned int> TidyTag_THEAD
    time = <unsigned int> TidyTag_TIME
    title = <unsigned int> TidyTag_TITLE
    tr = <unsigned int> TidyTag_TR
    track = <unsigned int> TidyTag_TRACK
    tt = <unsigned int> TidyTag_TT
    u = <unsigned int> TidyTag_U
    ul = <unsigned int> TidyTag_UL
    unknown = <unsigned int> TidyTag_UNKNOWN
    var = <unsigned int> TidyTag_VAR
    video = <unsigned int> TidyTag_VIDEO
    wbr = <unsigned int> TidyTag_WBR
    xmp = <unsigned int> TidyTag_XMP


class _TriState(IntEnum):
    __name__ =  __qualname__ = 'TriState'
    for_name = staticmethod(tri_state_for_name)

    auto = <unsigned int> TidyAutoState
    no = <unsigned int> TidyNoState
    yes = <unsigned int> TidyYesState


class _Uppercase(IntEnum):
    __name__ =  __qualname__ = 'Uppercase'
    for_name = staticmethod(uppercase_for_name)

    no = <unsigned int> TidyUppercaseNo
    preserve = <unsigned int> TidyUppercasePreserve
    yes = <unsigned int> TidyUppercaseYes


class _UseCustomTagsState(IntEnum):
    __name__ =  __qualname__ = 'UseCustomTagsState'
    for_name = staticmethod(use_custom_tags_state_for_name)

    blocklevel = <unsigned int> TidyCustomBlocklevel
    empty = <unsigned int> TidyCustomEmpty
    inline = <unsigned int> TidyCustomInline
    no = <unsigned int> TidyCustomNo
    pre = <unsigned int> TidyCustomPre


AttrId = _AttrId
AttrSortStrategy = _AttrSortStrategy
ConfigCategory = _ConfigCategory
DoctypeModes = _DoctypeModes
DupAttrModes = _DupAttrModes
EncodingOptions = _EncodingOptions
FormatParameterType = _FormatParameterType
LineEnding = _LineEnding
NodeType = _NodeType
OptionId = _OptionId
OptionType = _OptionType
ReportLevel = _ReportLevel
Strings = _Strings
TagId = _TagId
TriState = _TriState
Uppercase = _Uppercase
UseCustomTagsState = _UseCustomTagsState
