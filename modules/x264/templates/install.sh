#!/bin/sh -e

curl -sL ftp://ftp.videolan.org/pub/videolan/x264/snapshots/x264-snapshot-<%= @version %>-stable.tar.bz2 > x264-snapshot-<%= @version %>-stable.tar.gz
tar -xvf x264-snapshot-<%= @version %>-stable.tar.gz
cd x264-snapshot-<%= @version %>-stable
./configure --enable-shared
make
make install
