#!/bin/sh

apk add -q musl-dev gcc g++ py3-pip cmake make curl autoconf bison ninja cargo meson
apk add -q python3-dev
export MAKEFLAGS="-j$(nproc)"
export USE_CUDA=0
export CMAKE_ARGS="-DGGML_LLAMAFILE=OFF"
pip wheel -v -w /host/output llama-cpp-python
