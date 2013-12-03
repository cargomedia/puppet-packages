#!/bin/sh -e

git clone git://git.videolan.org/x264
cd x264
./configure --enable-shared
make
make install
