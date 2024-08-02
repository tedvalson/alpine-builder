#!/bin/sh

apk add -q musl-dev clang17 llvm17 py3-pip cmake make curl autoconf bison ninja cargo meson git
apk add -q python3-dev libgfortran openblas-dev libxslt-dev libxml2-dev qt6-qtbase-x11 qt6-qtbase-dev qt6-qtdeclarative-dev qt6-qt5compat-dev
#export MAKEFLAGS="-j$(nproc)"
#pip wheel -v -w /host/output juriscraper
git clone https://code.qt.io/qt-creator/qt-creator.git
cd qt-creator
git submodule update --init --recursive
mkdir qtcreator_build
cd qtcreator_build
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang-17 -DCMAKE_CXX_COMPILER=clang++-17 ..
#cmake --build . --config Release
#cmake --install . --config Release --prefix /host/output
make DESTDIR=/host/output install -j$(nproc)
