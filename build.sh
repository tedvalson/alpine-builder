#!/bin/sh
set -e
set -x

uname -a
apk update
apk add -q musl-dev gcc g++ clang18 llvm18 py3-pip cmake make curl autoconf bison ninja cargo meson git
apk add -q python3-dev openssl-dev clang18-libclang linux-headers
#apk add -q --no-cache libc6-compat pkgconfig dav1d libdav1d dav1d-dev npm gcc
pip wheel -v -w /host/output --no-deps llama-cpp-python
