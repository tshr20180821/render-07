#!/bin/bash

set -ex

export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

pushd /tmp
curl -LO https://github.com/rapier1/hpn-ssh/archive/refs/tags/18.2.0.tar.gz
tar xf 18.2.0.tar.gz

pushd hpn-ssh-18.2.0

autoreconf
./configure --help
./configure --prefix=/tmp/usr --with-pam --with-ipaddr-display

popd

popd