#! /usr/bin/env bash

set -eo

PATH="$(pwd)/DocSetUtil/bin:$PATH"

git submodule update --init --force

cd DocSetUtil
	make "prefix=$(pwd)" install || true
cd ..

cd glfw
	sed -i"" -e "s/1\\.9\\.8/1\\.9\\.7/" docs/CMakeLists.txt
cd ..

rm -rf build
mkdir -p build && cd build && cmake ../glfw

cd docs && patch Doxyfile < ../../Doxyfile.patch && make
sed -i"" -e "s/\$(XCODE_INSTALL)\\/usr\\/bin\\/docsetutil/docsetutil/" html/Makefile
cd html && make

cp -R GLFW.docset ../../../
