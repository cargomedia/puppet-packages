#!/bin/bash -e

curl -sL http://redis.googlecode.com/files/redis-<%= @version %>.tar.gz | tar -xzf -
cd redis-*
make
make install
