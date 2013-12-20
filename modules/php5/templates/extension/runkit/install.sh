#!/bin/bash -e

curl -sL https://github.com/downloads/zenovich/runkit/runkit-<%= @version %>.tgz | tar -xzf -
cd runkit-<%= @version %>
phpize
./configure
make
make install
