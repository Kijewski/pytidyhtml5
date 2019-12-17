def lib_info():
    '''
    Basic information about the loaded libtidy.so.

    Returns
    -------
    dict
        * ``"date"``: ``"yyyy/mm/dd"``
        * ``"version"``: ``"major.minor.patch"``
        * ``"platform``: e.g. ``"Linux"``
    '''
    return {
        'date': unicode(tidyReleaseDate(), 'UTF-8', 'replace'),
        'version': unicode(tidyLibraryVersion(), 'UTF-8', 'replace'),
        'platform': unicode(tidyPlatform(), 'UTF-8', 'replace'),
    }


def set_language(code):
    '''
    Set the language used in messages.

    Parameters
    ----------
    code : str
        Language code, e.g. ``"en"``.
    '''
    cdef char *string = NULL
    cdef Py_ssize_t length = 0
    cdef Bool result

    string = <char*> PyUnicode_AsUTF8AndSize(code, &length)
    result = tidySetLanguage(string)

    if result is no:
        raise Exception('Could not set language')


def get_language():
    '''
    Get the language used in messages

    Returns
    ----------
    str
        Current language used in messages, e.g. ``"en"``.
    '''
    cdef const char *string = NULL
    cdef Py_ssize_t length = 0

    string = <const char*> tidyGetLanguage()
    if string is NULL:
        return

    length  = strlen(string)
    return PyUnicode_DecodeUTF8(string, length, b'replace')


__version__ = PyUnicode_FromKindAndData(PyUnicode_1BYTE_KIND, VERSION, VERSION_LENGTH)
__doc__ = PyUnicode_FromKindAndData(PyUnicode_1BYTE_KIND, LONGDESCRIPTION, LONGDESCRIPTION_LENGTH)

__all__ = (
# Opaque types
'''
Document Node Attr Option
Message MessageArg
'''
# Enums
'''
OptionId ConfigCategory OptionType TriState UseCustomTagsState LineEnding
EncodingOptions DoctypeModes DupAttrModes AttrSortStrategy Uppercase
NodeType TagId AttrId ReportLevel FormatParameterType Strings ParseOutcome
'''
# Input
'''
InputSource FiledescriptorSource
'''
# Output buffer
'''
BufferType Buffer StringBuffer
'''
# Output sink
'''
CallbackSinkArgFormat OutputSink CallbackSink FiledescriptorSink
VoidSink
'''
# Convenience
'''
tidy_document tidy_fragment DocumentEncoding
'''
# General
'''
lib_info set_language get_language
'''
).split()
