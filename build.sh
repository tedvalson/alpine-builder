#!/bin/sh

apk add -q musl-dev gcc g++ py3-pip cmake make curl autoconf bison ninja cargo meson
apk add -q python3-dev libgfortran openblas-dev libxslt-dev libxml2-dev
export MAKEFLAGS="-j$(nproc)"
pip wheel -v -w /host/output juriscraper
