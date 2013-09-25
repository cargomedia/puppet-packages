#!/bin/bash
VERSION_NODE="<%= @version %>"

apt-get -qy install python libevent-1.4-2 libssl-dev
curl -sL http://nodejs.org/dist/v${VERSION_NODE}/node-v${VERSION_NODE}.tar.gz > node.tar.gz
tar -xvf node.tar.gz
cd node-*
./configure --prefix=/usr/
make
make install
