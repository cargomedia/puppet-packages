#!/bin/sh -e

curl -sL http://www.tortall.net/projects/yasm/releases/yasm-<%= @version %>.tar.gz > yasm-<%= @version %>.tar.gz
tar -xvf yasm-<%= @version %>.tar.gz
cd yasm-<%= @version %>
./configure
make
make install
