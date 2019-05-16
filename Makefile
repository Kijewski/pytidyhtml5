all: sdist bdist_wheel docs

NAME := pytidyhtml5

.PHONY: all sdist bdist_wheel clean docs

FILES := Makefile MANIFEST.in _${NAME}.pyx README.rst setup.py \
         lib/native.hpp lib/VERSION


TIDY_CFLAGS := -Os -fomit-frame-pointer -flto
TIDY_CFLAGS += -fPIC -ggdb1 -pipe
TIDY_CFLAGS += -fstack-protector-strong --param=ssp-buffer-size=8
TIDY_CFLAGS += -fvisibility=internal -fmerge-all-constants
TIDY_CFLAGS += -std=c11 -D_ISOC11_SOURCE -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE

tidy-html5/build/cmake/libtidys.a:
	cd tidy-html5/build/cmake && \
		cmake ../.. \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SHARED_LIBS=OFF \
			-DCMAKE_C_FLAGS="${TIDY_CFLAGS}"
	cd tidy-html5/build/cmake && \
		$(MAKE) VERBOSE=1 -B

lib/_import_tidy_enum.pyx: tidy-html5/build/cmake/libtidys.a
	./generate_imports.py

_${NAME}.cpp: _${NAME}.pyx $(wildcard lib/*.pyx) lib/_import_tidy_enum.pyx
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
