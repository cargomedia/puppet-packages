#!/bin/sh -e

rm -rf usrsctp
git clone https://github.com/sctplab/usrsctp
cd usrsctp
./bootstrap
./configure --prefix=/usr
make
make uninstall
make install
