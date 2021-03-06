#!/bin/sh
set -e
BASE=$(pwd)
PB_VERSION=3.1.0

if [ -d ${BASE}/protobuf-${PB_VERSION} ]
then
    rm -rf ${BASE}/protobuf-${PB_VERSION}
fi
    
tar xvf ${BASE}/protobuf-${PB_VERSION}.tar.gz

cd ${BASE}/protobuf-${PB_VERSION}
./autogen.sh
./configure
make -j4

mkdir -p ${BASE}/../lib/linux
cp src/.libs/libprotoc.a ${BASE}/../lib/linux
cp src/libprotoc.la ${BASE}/../lib/linux

cp src/.libs/libprotobuf.a ${BASE}/../lib/linux
cp src/libprotobuf.la ${BASE}/../lib/linux
