#!/bin/bash
VERSION_NODE="<%= @version %>"

curl -sL http://nodejs.org/dist/v${VERSION_NODE}/node-v${VERSION_NODE}.tar.gz > node.tar.gz
tar -xvf node.tar.gz
cd node-*
./configure --prefix=/usr/
make
make install
