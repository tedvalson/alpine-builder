#!/bin/sh

apk add -q musl-dev gcc g++ clang18 llvm18 py3-pip cmake make curl autoconf bison ninja cargo meson git
apk add -q python3-dev libgfortran openblas-dev libxslt-dev libxml2-dev qt6-qtbase-x11 qt6-qtbase-dev qt6-qtdeclarative-dev qt6-qt5compat-dev qt6-qttools-dev qt6-qttools-libs qt6-qtwebengine-dev elfutils-dev
export MAKEFLAGS="-j$(nproc)"
export LDFLAGS="-lexecinfo"
export CXXFLAGS="-Wl,--start-group -Wl,-lexecinfo"
git clone https://github.com/resslinux/libexecinfo.git
cd libexecinfo
make install -j4
cd ..

#pip wheel --no-deps -v -w /host/output doccano
[ -d "/host/build" ] || git clone --single-branch --branch 14.0 https://code.qt.io/qt-creator/qt-creator.git /host/build
cd /host/build
git submodule update --init --recursive
sed -i 's/Q_OS_LINUX/__GLIBC__/g' src/plugins/coreplugin/icore.cpp
#cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_C_COMPILER=clang-18 -DCMAKE_CXX_COMPILER=clang++-18 ..
cmake -B./build -S. -DCMAKE_BUILD_TYPE=Release
#cmake --build ./build --target help
#cmake --build . --config Release
#cmake --install . --config Release --prefix /host/output
cd build
#make -j$(nproc) Designer
VERBOSE=1 make DESTDIR=/host/output install -j$(nproc)
