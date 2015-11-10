#!/bin/sh -e

wget https://github.com/cisco/libsrtp/archive/v<%= @version %>.tar.gz
tar -xzf v<%= @version %>.tar.gz
cd libsrtp-<%= @version %>
./configure --prefix=/usr --enable-openssl
make libsrtp.so
make uninstall
make install

if <%= @build_tests %>; then
    ./configure --prefix=/usr --enable-openssl
    make test
    cp test/rtpw /usr/local/bin/
    cp test/rtpw_* /usr/local/bin/
fi
