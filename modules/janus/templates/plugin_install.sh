#!/bin/sh -e

cd "<%= @src_path %>"
./get-janus-headers.sh
./autogen.sh
./configure --prefix=/usr

make
make install
