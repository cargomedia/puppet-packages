#!/bin/sh -e

curl -sL https://github.com/yasm/yasm/archive/v<%= @version %>.zip > yasm-<%= @version %>.zip
unzip yasm-<%= @version %>.zip
cd yasm-<%= @version %>
./autogen.sh
make
make install
