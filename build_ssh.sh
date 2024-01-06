#!/bin/bash

set -ex

gcc -### -E - -march=native 2>&1 | sed -r '/cc1/!d;s/(")|(^.* - )//g' >/tmp/cflags_option

cflags_option=$(cat /tmp/cflags_option)
export CFLAGS="-O2 ${cflags_option} -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

apt-get -qq update
apt-get install zlib1g-dev libssl-dev libmd-dev libpam0g-dev libfido2-dev

pushd /tmp
curl -sSLO https://github.com/rapier1/hpn-ssh/archive/refs/tags/18.2.0.tar.gz
tar xf 18.2.0.tar.gz

pushd hpn-ssh-18.2.0

autoreconf
./configure --help
time ./configure --with-pam --with-ipaddr-display
time make -j7
find ./ -name hpnssh -print
ldd ./hpnssh
find ./ -name hpnsshd -print
ldd ./hpnsshd
popd

popd
