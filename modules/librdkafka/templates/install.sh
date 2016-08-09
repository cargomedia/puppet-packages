#!/bin/bash -e

curl -sL https://github.com/edenhill/librdkafka/archive/<%= @version %>.tar.gz | tar -xzf -
cd librdkafka-<%= @version %>/
./configure
make
make install
