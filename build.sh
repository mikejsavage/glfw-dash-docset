#!/bin/bash
git submodule init
git submodule update
mkdir -p build && cd build && cmake ../glfw
cd docs && patch Doxyfile < ../../Doxyfile.patch && make
cd html && make
cp -R GLFW.docset ../../../
