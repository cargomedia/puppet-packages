#!/bin/sh -e

cd /opt/janus/build/<%= @name %>
./autogen.sh
./configure --prefix=/usr
make
make install
