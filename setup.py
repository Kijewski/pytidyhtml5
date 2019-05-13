#!/usr/bin/env python

from setuptools import setup, Extension
from os.path import dirname, join, abspath


def get_text(name):
    root = abspath(dirname(__file__))
    with open(join(root, 'lib', name), 'rt') as f:
        return eval(f.read().strip())


extra_compile_args = [
    '-std=c++11',

    '-Os', '-fomit-frame-pointer', '-fPIC', '-ggdb1', '-pipe',
    '-D_FORTIFY_SOURCE=2', '-fstack-protector-strong', '--param=ssp-buffer-size=8',
    '-isystem', '/home/kijewski/opt/tidy5/include',
]

extra_link_args = [
    *extra_compile_args,
    '-L/home/kijewski/local/tidy-html5/lib',
    '-ltidy',
    '-fPIC',
    '-Wl,-zrelro,-znow,-zcombreloc,-znocommon,-znoexecstack',
]

name = 'pytidyhtml5'

setup(
    name=name,
    version=get_text('VERSION'),
    long_description=get_text('DESCRIPTION'),
    description='TODO',
    author='René Kijewski',
    author_email='pypi.org@k6i.de',
    maintainer='René Kijewski',
    maintainer_email='pypi.org@k6i.de',
    url='https://github.com/Kijewski/pyjson5',
    python_requires='~= 3.4',
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
    license='Apache 2.0',
    classifiers=[
    ],
)
