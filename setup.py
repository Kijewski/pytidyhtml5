#!/usr/bin/env python

from setuptools import setup, Extension
from os.path import dirname, join, abspath


def get_text(name):
    root = abspath(dirname(__file__))
    with open(join(root, 'lib', name), 'rt') as f:
        return eval(f.read().strip())


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
        'Development Status :: 4 - Beta',
        'Intended Audience :: Developers',
        'Intended Audience :: System Administrators',
        'License :: OSI Approved :: ISC License (ISCL)',
        'Operating System :: OS Independent',
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
