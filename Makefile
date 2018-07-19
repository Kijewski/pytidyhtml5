all: sdist bdist_wheel docs

NAME := pytidyhtml5

.PHONY: all sdist bdist_wheel clean docs

FILES := Makefile MANIFEST.in _${NAME}.pyx README.rst setup.py \
         lib/native.hpp lib/VERSION

_${NAME}.cpp: _${NAME}.pyx $(wildcard lib/*.pyx)
	./generate_imports.py
	rm -f -- dist/*.so _${NAME}.cpp
	rm -f ./_${NAME}.cpp
	cythonize $<

sdist: _${NAME}.cpp ${FILES}
	rm -f -- dist/${NAME}-*.tar.gz
	python setup.py sdist --format=gztar
	python setup.py sdist --format=xztar

bdist_wheel: _${NAME}.cpp ${FILES} | sdist
	rm -f -- dist/${NAME}-*.whl
	python setup.py bdist_wheel

docs: bdist_wheel $(wildcard docs/* docs/*/*)
	[ ! -d dist/docs/ ] || rm -r -- dist/html/
	pip install --force dist/${NAME}-*.whl
	python -m sphinx -M html docs/ dist/

clean:
	[ ! -f build/ ] || rm -- lib/_import_tidy_enum.pyx
	[ ! -f build/ ] || rm -- lib/_tidy_enum.pyx
	[ ! -d build/ ] || rm -r -- build/
	[ ! -d dist/ ] || rm -r -- dist/
	[ ! -d ${NAME}.egg-info/ ] || rm -r -- ${NAME}.egg-info/
	rm -f -- dist/.*.so _${NAME}.cpp
	-pip uninstall pytidyhtml5 -y
