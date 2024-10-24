#!/usr/bin/env python3

from setuptools import setup, Extension


extra_compile_args = [
    "-std=c++11",
    "-flto",
    "-O3",
    "-fPIC",
    "-g0",
    "-pipe",
    "-Itidy-html5/include/",
]
extra_link_args = [
    *extra_compile_args,
    "tidy-html5/build/cmake/libtidy.a",
]

name = "pytidyhtml5"
setup(
    ext_modules=[
        Extension(
            "_" + name,
            sources=["_" + name + ".cpp"],
            include_dirs=["lib"],
            extra_compile_args=extra_compile_args,
            extra_link_args=extra_link_args,
            language="c++",
        )
    ],
)
