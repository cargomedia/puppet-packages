#!/bin/sh -e

wget https://github.com/cisco/libsrtp/archive/v<%= @version %>.tar.gz
tar -xzf v<%= @version %>.tar.gz
cd libsrtp-<%= @version %>
./configure --prefix=/usr --enable-openssl
make libsrtp.so
make uninstall
make install
