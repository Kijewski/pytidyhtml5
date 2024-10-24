# distutils: language = c++
# cython: embedsignature = True, language_level = 3, warn.unreachable = True, warn.maybe_uninitialized = True

#   Copyright 2019-2024 René Kijewski
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

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
