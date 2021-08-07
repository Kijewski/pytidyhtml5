#!/usr/bin/env python3

from os.path import dirname, join, abspath
from os import environ
from platform import system
from setuptools import setup, Extension
from subprocess import check_output
from sys import argv
from traceback import print_last


def get_text(name):
    root = abspath(dirname(__file__))
    with open(join(root, 'lib', name), 'rt') as f:
        return eval(f.read().strip())


if system() == 'Linux':
    extra_compile_args = [
        '-std=c++11', '-flto',
        '-O2', '-fomit-frame-pointer', '-fPIC', '-ggdb1', '-pipe',
        '-D_FORTIFY_SOURCE=2', '-fstack-protector-strong', '--param=ssp-buffer-size=8',
        '-isystem', 'tidy-html5/include/',
    ]
    extra_link_args = [
        *extra_compile_args,
        'tidy-html5/build/cmake/libtidy.a',
        '-fPIC',
        '-Wl,-zrelro,-znow,-zcombreloc,-znocommon,-znoexecstack',
    ]
else:
    # OSX or Windows
    extra_compile_args = [
        '-std=c++11', '-flto',
        '-O2', '-fomit-frame-pointer', '-fPIC', '-ggdb1', '-pipe',
        '-D_FORTIFY_SOURCE=2', '-fstack-protector-strong', '--param=ssp-buffer-size=8',
        '-isystem', 'tidy-html5/include/',
    ]
    extra_link_args = [
        *extra_compile_args,
        'tidy-html5/build/cmake/libtidy.a',
        '-fPIC',
    ]

if system() == 'Windows':
    # I cannot get cibuildwheel to accept my CC + CXX overrides. :(
    # So monkey patching it is ...

    for line in check_output(['make', 'export-environ']).decode('UTF-8').splitlines():
        (key, value) = line.split('=', 1)
        environ[key] = value

    import distutils.command.build_ext

    def customize_compiler(compiler):
        compiler_settings = [
            environ['CXX'], '-m64',
            '-Wall', '-Wno-unused-result', '-Wformat', '-Werror=format-security', '-Wdate-time',
            '-O2', '-g', '-fwrapv', '-fstack-protector-strong',
            '-DNDEBUG', '-D_FORTIFY_SOURCE=2',

            '-DMS_WIN64', # https://github.com/cython/cython/issues/3405#issuecomment-596975159
        ]

        compiler.preprocessor = [environ['CXX'], '-m64', '-E', '-Wdate-time', '-D_FORTIFY_SOURCE=2']
        compiler.compiler = [*compiler_settings]
        compiler.compiler_cxx = [*compiler_settings]
        compiler.compiler_so = [*compiler_settings, '-fPIC']
        compiler.linker_so = [*compiler_settings, '-shared']
        compiler.linker_exe = [*compiler_settings, '-fPIC']
        compiler.archiver = [environ['AR'], environ['ARFLAGS']]
        compiler.ranlib = [environ['RANLIB']]

    class build_ext(distutils.command.build_ext.build_ext):
        def run(self):
            self.compiler = 'unix'
            return super().run()

        def build_extensions(self):
            print('self.compiler', repr(vars(self.compiler)))
            return super().build_extensions()

    distutils.command.build_ext.customize_compiler = customize_compiler
    distutils.command.build_ext.build_ext = build_ext


name = 'pytidyhtml5'
setup(
    name=name,
    version=get_text('VERSION.txt'),
    long_description=get_text('DESCRIPTION.txt'),
    description='HTML clean-up and repair: Statically linked Python interface for tidy-html5.',
    author='René Kijewski',
    author_email='pypi.org@k6i.de',
    maintainer='René Kijewski',
    maintainer_email='pypi.org@k6i.de',
    url='https://github.com/Kijewski/pytidyhtml5',
    python_requires='~= 3.6',
    zip_safe=False,
    ext_modules=[Extension(
        '_' + name,
        sources=['_' + name + '.pyx'],
        include_dirs=['lib'],
        extra_compile_args=extra_compile_args,
        extra_link_args=extra_link_args,
        language='c++',
    )],
    packages=[name],
    platforms=['any'],
    license='ISC',
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'License :: OSI Approved :: ISC License (ISCL)',
        'Operating System :: POSIX :: Linux',
        'Operating System :: MacOS :: MacOS X',
        'Operating System :: Microsoft :: Windows',
        'Programming Language :: Cython',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.6',
        'Programming Language :: Python :: 3.7',
        'Programming Language :: Python :: 3.8',
        'Programming Language :: Python :: 3.9',
        'Programming Language :: Python :: 3 :: Only',
        'Programming Language :: Python :: Implementation :: CPython',
        'Programming Language :: Python :: Implementation :: PyPy',
        'Topic :: Text Processing :: Markup :: HTML ',
    ],
)
