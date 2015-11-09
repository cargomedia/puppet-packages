#!/bin/sh -e

wget https://github.com/cisco/libsrtp/archive/v<%= @version %>.tar.gz
tar -xzf v<%= @version %>.tar.gz
cd libsrtp-<%= @version %>
    ./configure --prefix=/usr --enable-openssl --libdir=/usr/lib64
make libsrtp.so && make uninstall && make install
if <%= @build_tests %>; then
    ./configure --prefix=/usr --enable-openssl --libdir=/usr/lib64
    make test
    cp test/rtpw /usr/local/bin/
    cp test/rtpw_* /usr/local/bin/
fi
