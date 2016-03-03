#!/bin/sh -e

cd "<%= @src_path %>"
./autogen.sh
./configure --prefix=/usr
make
make install
