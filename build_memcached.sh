#!/bin/bash

set -e

export CFLAGS="-O2 -march=native -mtune=native -fomit-frame-pointer"
export CXXFLAGS="$CFLAGS"
export LDFLAGS="-fuse-ld=gold"

pushd /tmp
curl -O https://memcached.org/files/memcached-1.6.22.tar.gz
tar xf memcached-1.6.22.tar.gz

pushd memcached-1.6.22

copy -f /usr/src/app/proto_bin.c ./

./configure --help

# ./configure --enable-sasl --enable-sasl-pwdb --enable-static --enable-64bit --disable-docs
./configure --enable-sasl --enable-sasl-pwdb --enable-64bit --disable-docs

make
make install

popd

ldd /usr/local/bin/memcached
cp /usr/local/bin/memcached /var/www/html/

popd
