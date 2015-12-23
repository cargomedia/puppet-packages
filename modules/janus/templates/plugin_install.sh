#!/bin/sh -e

cd /opt/janus/<%= @plugin_repo %>
./autogen.sh
./configure --prefix=/usr
make
make install
