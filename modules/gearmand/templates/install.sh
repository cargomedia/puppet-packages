#!/bin/bash -e

curl -sL https://launchpad.net/gearmand/<%= @server_series %>/<%= @server_version %>/+download/gearmand-<%= @server_version %>.tar.gz | tar -xzf -
cd gearmand-*
./configure
make
make install
