all: sdist bdist_wheel docs

.DELETE_ON_ERROR:

NAME := pytidyhtml5

.PHONY: all sdist bdist_wheel clean docs prepare clean-generated clean-artifacts export-environ install

FILES := Makefile MANIFEST.in _${NAME}.pyx README.rst setup.py \
         lib/native.hpp lib/VERSION.txt lib/DESCRIPTION.txt \
         tidy-html5/build/cmake/libtidy.a


TIDY_CFLAGS := -O3 -flto -fPIC -g0 -pipe
TIDY_CFLAGS += -fvisibility=internal -fmerge-all-constants
TIDY_CFLAGS += -std=c11 -D_ISOC11_SOURCE -D_GNU_SOURCE


CC:=$(shell which gcc clang g++ clang++ | head -n1 2> /dev/null)
CXX:=$(shell which g++ clang++ gcc clang | head -n1 2> /dev/null)
AR:=$(shell which gcc-ar llvm-ar ar | head -n1 2> /dev/null)
RANLIB:=$(shell which gcc-ranlib llvm-ranlib ranlib | head -n1 2> /dev/null)

ifeq ($(findstring */c/,*${CC}),*/c/)
  CC:=$(patsubst /c/%,c:/%,${CC}).exe
endif

ifeq ($(findstring */c/,*${CXX}),*/c/)
  CXX:=$(patsubst /c/%,c:/%,${CXX}).exe
endif

ifeq ($(findstring */c/,*${AR}),*/c/)
  AR:=$(patsubst /c/%,c:/%,${AR}).exe
endif

ifeq ($(findstring */c/,*${RANLIB}),*/c/)
  RANLIB:=$(patsubst /c/%,c:/%,${RANLIB}).exe
endif

export CC
export CXX
export AR
export ARFLAGS
export RANLIB


tidy-html5/.git:
	git submodule init
	git submodule update

tidy-html5/build/cmake/libtidy.a: | tidy-html5/.git
	cd tidy-html5/build/cmake && \
		cmake ../.. \
			"-GUnix Makefiles" \
			-DCMAKE_BUILD_TYPE=Release \
			-DBUILD_SHARED_LIBS=OFF \
			-DCMAKE_C_FLAGS="${TIDY_CFLAGS}" \
			-DCMAKE_C_COMPILER="${CC}" \
			-DCMAKE_CXX_COMPILER="${CXX}" \
			-DCMAKE_AR="${AR}" \
			-DCMAKE_RANLIB="${RANLIB}"

	cd tidy-html5/build/cmake/ && \
		$(MAKE) VERBOSE=1 -B tidy-static

	-mv tidy-html5/build/cmake/libtidy_static.a tidy-html5/build/cmake/libtidy.a
	$(RANLIB) $@

	-rm tidy-html5/build/cmake/libtidy.so*

lib/_import_tidy_enum.pyx:
	./generate_imports.py

_${NAME}.cpp: _${NAME}.pyx $(wildcard lib/*.pyx) | lib/_import_tidy_enum.pyx
	-rm -- dist/*.so
	-rm ./_${NAME}.cpp

	python3 -m Cython.Build.Cythonize -f $<

	sed -i.bak '1s;^;#include "./lib/_fix-mingw32-w64s-cmath.h"\
;' $@
	sed -i.bak 's/%z/%" PY_FORMAT_SIZE_T "/g' $@

prepare: _${NAME}.cpp ${FILES}

sdist: _${NAME}.cpp ${FILES}
	-rm -- dist/${NAME}-*.tar.gz
	python3 -m build --sdist

bdist_wheel: _${NAME}.cpp ${FILES} | sdist
	-rm -- dist/${NAME}-*.whl
	python3 -m build --wheel

install: bdist_wheel
	python3 -m pip install --force dist/pytidyhtml5-*.whl

docs: install $(wildcard docs/* docs/*/*)
	-rm -r -- dist/html/
	pip install --force dist/${NAME}-*.whl
	python3 -m sphinx -M html docs/ dist/

clean: clean-generated clean-artifacts

clean-generated:
	-rm -- _${NAME}.cpp
	-rm -- ./lib/_import_tidy_enum.pyx
	-rm -- ./lib/_tidy_enum.pyx

clean-artifacts:
	-cd ./tidy-html5/ && git clean -xdf -- build/cmake/
	-rm -r -- ./build/
	-rm -r -- ./dist/
	-rm -r -- ./"${NAME}.egg-info/"
	-pip uninstall pytidyhtml5 -y

export-environ:
	@echo CC=${CC}
	@echo CXX=${CXX}
	@echo AR=${AR}
	@echo ARFLAGS=${ARFLAGS}
	@echo RANLIB=${RANLIB}
