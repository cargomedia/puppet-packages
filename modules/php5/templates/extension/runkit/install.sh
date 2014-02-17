#!/bin/bash -e

git clone https://github.com/zenovich/runkit.git && cd runkit
git fetch && git checkout <%= @commit %>

phpize
./configure
make
make install
