#!/bin/bash -e

curl -sL https://launchpad.net/gearmand/<%= @series %>/<%= @version %>/+download/gearmand-<%= @version %>.tar.gz | tar -xzf -
cd gearmand-*
./configure
make
make install
