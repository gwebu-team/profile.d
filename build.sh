#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob dotglob

if [ "$(uname -s)" != "Linux" ]; then
    echo "This script only works on Linux!" >&2
    exit 254
fi
set -x # debug

. /etc/os-release
ARCH="${ARCH:-$(uname -m)}"         #
VER="${VER:-${VERSION_ID%%\.*}}"    # 9
DIST_PRE="${PLATFORM_ID##*:}"       # el9
DIST="${DIST:-${DIST_PRE%%[0-9]*}}" # el
OUT_DIR="/tmp/RPMS"

export LANG='C.UTF-8'
export LANGUAGE="${LANG}"
export LC_ALL="${LANG}"
export LC_MEASUREMENT="${LANG}"
export LC_MONETARY="${LANG}"
export LC_NUMERIC="${LANG}"
export LC_TIME="${LANG}"

rm -rf "$OUT_DIR"
mkdir "$OUT_DIR"

# Download all sources and patches.
#spectool -g ./*.spec
#
# Install all build dependencies.
#if [ "$UID" == "0" ]; then
#    dnf builddep -y --refresh ./*.spec
#fi

# make dist

rpmbuild -ta ./dist/*.tar.xz \
    --define "_sourcedir $PWD/dist" \
    --define "_srcrpmdir $OUT_DIR" \
    --define "_rpmdir $OUT_DIR"

mv "$OUT_DIR"/*/*.rpm "$OUT_DIR/"
rmdir "$OUT_DIR"/* 2>/dev/null || true
