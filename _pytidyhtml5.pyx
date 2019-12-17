# distutils: language = c++
# cython: embedsignature = True, language_level = 3, warn.unreachable = True, warn.maybe_uninitialized = True


include 'lib/_import_tidy_platform.pyx'
include 'lib/_imports.pyx'
include 'lib/_import_python.pyx'
include 'lib/_import_tidy_enum.pyx'
include 'lib/_import_tidy.pyx'
include 'lib/_enum_by_name.pyx'
include 'lib/_tidy_enum.pyx'
include 'lib/_allocator.pyx'
include 'lib/_tidy_options.pyx'
include 'lib/_tidy_document.pyx'
include 'lib/_tidy_node.pyx'
include 'lib/_tidy_attr.pyx'
include 'lib/_tidy_message.pyx'
include 'lib/_input_source.pyx'
include 'lib/_input_ucs.pyx'
include 'lib/_output_buffer.pyx'
include 'lib/_output_sink.pyx'
include 'lib/_convenience.pyx'
include 'lib/_version.pyx'
