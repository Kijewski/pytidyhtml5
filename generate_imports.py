#!/usr/bin/env python3

from glob import glob
from keyword import iskeyword
from os.path import join, abspath, dirname
from re import match

from clang.cindex import Index, Config, CursorKind
from inflection import underscore


root = abspath(dirname(__file__))

Config.set_library_file(sorted(
    glob('/usr/lib/llvm-*/lib/libclang.so.1'),
    key=lambda p: float(match(r'/usr/lib/llvm-(\d+(?:[.]\d+)?)/', p).group(1)),
    reverse=True,
)[0])

index = Index.create()
tu = index.parse(join(root, 'generate_imports_transclusion.h'))

enums = {}

for cursor in tu.cursor.get_children():
    if cursor.kind is CursorKind.TYPEDEF_DECL:
        direct_children = list(cursor.get_children())
        if len(direct_children) != 1:
            continue

        direct_child, = direct_children
        if direct_child.kind is not CursorKind.ENUM_DECL:
            continue

        enums[cursor.spelling] = {
            'type': direct_child.enum_type.spelling,
            'values': {
                definition.spelling: definition.enum_value
                for definition in direct_child.get_children()
            },
        }

with open(join(root, 'lib', '_import_tidy_enum.pyx'), 'wt') as f:
    print("# GENERATED FILE: all modifications will be overwritten.", file=f)
    print(file=f)
    print("cdef extern from 'tidyenum.h' nogil:", file=f)

    print(file=f)
    print("    # Rationale: If Cython thinks the enums are T*, then it won't automagically convert to ints,", file=f)
    print("    #            so it's easier to find wrong type usage.", file=f)

    print(file=f)
    for enumname in sorted(enums):
        if enumname.lower().startswith('tidy'):
            print("    ctypedef struct __Enum__", enumname, file=f, sep='')

    print(file=f)
    for enumname in sorted(enums):
        if enumname.lower().startswith('tidy'):
            print("    ctypedef __Enum__", enumname, " *", enumname, " ", repr(enumname), file=f, sep='')

    for enumname, definition in sorted(enums.items()):
        if enumname.lower().startswith('tidy'):
            print(file=f)
            for valuename in sorted(definition['values']):
                print("    const ", enumname, " ", valuename, file=f, sep='')


clsnames = {
    'AttrId':              ('TidyAttr_',       '',      'TidyAttrId'),
    'AttrSortStrategy':    ('TidySortAttr',    '',      'TidyAttrSortStrategy'),
    'ConfigCategory':      ('Tidy',            '',      'TidyConfigCategory'),
    'DoctypeModes':        ('TidyDoctype',     '',      'TidyDoctypeModes'),
    'DupAttrModes':        ('Tidy',            '',      'TidyDupAttrModes'),
    'EncodingOptions':     ('TidyEnc',         '',      'TidyEncodingOptions'),
    'FormatParameterType': ('tidyFormatType_', '',      'TidyFormatParameterType'),
    'LineEnding':          ('Tidy',            '',      'TidyLineEnding'),
    'NodeType':            ('TidyNode_',       '',      'TidyNodeType'),
    'OptionId':            ('Tidy',            '',      'TidyOptionId'),
    'OptionType':          ('Tidy',            '',      'TidyOptionType'),
    'ReportLevel':         ('Tidy',            '',      'TidyReportLevel'),
    'Strings':             ('',                '',      'tidyStrings'),
    'TagId':               ('TidyTag_',        '',      'TidyTagId'),
    'TriState':            ('Tidy',            'State', 'TidyTriState'),
    'Uppercase':           ('TidyUppercase',   '',      'TidyUppercase'),
    'UseCustomTagsState':  ('TidyCustom',      '',      'TidyUseCustomTagsState'),
}

with open(join(root, 'lib', '_tidy_enum.pyx'), 'wt') as f:
    print("# GENERATED FILE: all modifications will be overwritten.", file=f)

    print(file=f)
    for clsname, (prefix, suffix, enumname) in sorted(clsnames.items()):
        print("cdef object _", clsname, file=f, sep='')

    print(file=f)
    for clsname, (prefix, suffix, enumname) in sorted(clsnames.items()):
        print("global ", clsname, file=f, sep='')

    print(file=f)
    for clsname in sorted(clsnames):
        print(file=f)
        print("cdef object ", underscore(clsname), "_for_name(name):", file=f, sep='')
        print("    return _generic_id_for_name(_", clsname, ", name)", file=f, sep='')

    for clsname, (prefix, suffix, enumname) in sorted(clsnames.items()):
        definition = enums[enumname]

        print(file=f)
        print(file=f)
        print("_", clsname, " = IntEnum(", repr(clsname), ", {", file=f, sep='')
        for valuename in sorted(definition['values']):
            pretty_name = valuename
            if prefix and pretty_name.startswith(prefix):
                pretty_name = pretty_name[len(prefix):]
            if suffix and pretty_name.endswith(suffix):
                pretty_name = pretty_name[:-len(suffix)]
            pretty_name = underscore(pretty_name)

            if pretty_name.startswith('n_tidy_'):
                continue

            if iskeyword(pretty_name):
                pretty_name = f'{pretty_name}_'

            print("    ", repr(pretty_name), ": <", definition['type'], "> ", valuename, ",", file=f, sep='')

        print("})", file=f)
        print(file=f)
        print("_", clsname, ".for_name = ", underscore(clsname), "_for_name", file=f, sep='')
        print(file=f)
        print(clsname, " = _", clsname, file=f, sep='')
