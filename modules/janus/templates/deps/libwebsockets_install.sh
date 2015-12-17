#!/bin/sh -e

rm -rf libwebsocket
wget http://git.libwebsockets.org/cgi-bin/cgit/libwebsockets/snapshot/libwebsockets-1.5-chrome47-firefox41.tar.gz
tar -xzf libwebsockets-1.5-chrome47-firefox41.tar.gz
cd libwebsockets-1.5-chrome47-firefox41
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr ..
make
make install
