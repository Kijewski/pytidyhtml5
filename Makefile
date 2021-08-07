all: sdist bdist_wheel docs

.DELETE_ON_ERROR:

NAME := pytidyhtml5

.PHONY: all sdist bdist_wheel clean docs prepare clean-generated clean-artifacts

FILES := Makefile MANIFEST.in _${NAME}.pyx README.rst setup.py \
         lib/native.hpp lib/VERSION.txt lib/DESCRIPTION.txt \
         tidy-html5/build/cmake/libtidy.a


TIDY_CFLAGS := -O2 -fomit-frame-pointer -flto
TIDY_CFLAGS += -fPIC -ggdb1 -pipe
TIDY_CFLAGS += -fstack-protector-strong --param=ssp-buffer-size=8
TIDY_CFLAGS += -fvisibility=internal -fmerge-all-constants
TIDY_CFLAGS += -std=c11 -D_ISOC11_SOURCE -D_FORTIFY_SOURCE=2 -D_GNU_SOURCE

export CC = $(shell which gcc clang g++ clang++ | head -n1)
export CXX = $(shell which g++ clang++ gcc clang | head -n1)
export AR = $(shell which gcc-ar llvm-ar ar | head -n1)
export RANLIB = $(shell which gcc-ranlib llvm-ranlib ranlib | head -n1)

$(info CC=${CC})
$(info CXX=${CXX})
$(info AR=${AR})
$(info RANLIB=${RANLIB})

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
			-DCMAKE_C_COMPILER="${CC}" \
			-DCMAKE_CXX_COMPILER="${CXX}" \
			-DCMAKE_AR="${AR}" \
			-DCMAKE_RANLIB="${RANLIB}"

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
	-rm -- dist/${NAME}-*.tar.gz
	python setup.py sdist --format=gztar
	python setup.py sdist --format=xztar

bdist_wheel: _${NAME}.cpp ${FILES} | sdist
	-rm -- dist/${NAME}-*.whl
	python setup.py bdist_wheel

docs: bdist_wheel $(wildcard docs/* docs/*/*)
	-rm -r -- dist/html/
	pip install --force dist/${NAME}-*.whl
	python -m sphinx -M html docs/ dist/

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
