#!/bin/sh -e

cd /opt/src/janus-plugins/usrsctp
./bootstrap
./configure --prefix=/usr
make
make uninstall
make install
