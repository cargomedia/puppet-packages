#!/bin/sh -e

wget http://git.libwebsockets.org/cgi-bin/cgit/libwebsockets/snapshot/<%= @version_file_name %>.tar.gz
tar -xzf <%= @version_file_name %>.tar.gz
cd <%= @version_file_name %>
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make
make install
