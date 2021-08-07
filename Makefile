all: sdist bdist_wheel docs

.DELETE_ON_ERROR:

NAME := pytidyhtml5

.PHONY: all sdist bdist_wheel clean docs prepare

FILES := Makefile MANIFEST.in _${NAME}.pyx README.rst setup.py \
         lib/native.hpp lib/VERSION tidy-html5/build/cmake/libtidy.a


TIDY_CFLAGS := -O2 -fomit-frame-pointer -flto
TIDY_CFLAGS += -fPIC -ggdb1 -pipe
TIDY_CFLAGS += -fstack-protector-strong --param=ssp-buffer-size=8
TIDY_CFLAGS += -fvisibility=internal -fmerge-all-constants
TIDY_CFLAGS += -std=c11 -D_ISOC11_SOURCE -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE

export CC
export CXX

export AR = gcc-ar
export RANLIB = gcc-ranlib


tidy-html5/.git:
	git submodule init
	git submodule update

tidy-html5/build/cmake/libtidy.a: | tidy-html5/.git
	mkdir -p tidy-html5/build/

	cd tidy-html5/build/cmake && \
		cmake ../.. \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SHARED_LIBS=OFF \
			-DCMAKE_C_FLAGS="${TIDY_CFLAGS}" \
			-DCMAKE_C_COMPILER="`/usr/bin/which "${CC}"`" \
			-DCMAKE_CXX_COMPILER="`/usr/bin/which "${CXX}"`" \
			-DCMAKE_AR="`/usr/bin/which "$${AR}"`" \
			-DCMAKE_RANLIB="`/usr/bin/which "$${RANLIB}"`"

	cd tidy-html5/build/cmake/ && \
		$(MAKE) VERBOSE=1 -B

	$(RANLIB) $@

	-rm tidy-html5/build/cmake/libtidy.so

lib/_import_tidy_enum.pyx:
	./generate_imports.py

_${NAME}.cpp: _${NAME}.pyx $(wildcard lib/*.pyx) | lib/_import_tidy_enum.pyx
	-rm -- dist/*.so
	-rm ./_${NAME}.cpp
	python -m Cython.Build.Cythonize -f $<

prepare: _${NAME}.cpp ${FILES}

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
	-rm -- _${NAME}.cpp
	-rm -- ./lib/_import_tidy_enum.pyx
	-rm -- ./lib/_tidy_enum.pyx
	-rm -r -- ./build/
	-rm -r -- ./dist/
	-rm -r -- ./"${NAME}.egg-info/"
	-cd ./tidy-html5/ && git clean -xdf -- build/cmake/
	-pip uninstall pytidyhtml5 -y
