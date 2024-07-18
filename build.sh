#!/bin/sh

apk add -q musl-dev gcc g++ py3-pip cmake make curl autoconf bison ninja
apk add -q python3-dev libxml2-dev libxslt-dev yaml
export MAKEFLAGS="-j$(nproc)"
pip wheel -v -w /host/output lxml
