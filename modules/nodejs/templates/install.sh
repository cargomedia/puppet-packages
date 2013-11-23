#!/bin/bash -e

curl -sL http://nodejs.org/dist/v<%= @version %>/node-v<%= @version %>.tar.gz > node.tar.gz
tar -xvf node.tar.gz
cd node-*
./configure --prefix=/usr/
make
make install
