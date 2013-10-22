#!/bin/bash
VERSION="<%= @version %>"
curl -sL http://redis.googlecode.com/files/redis-${VERSION}.tar.gz | tar -xzf -
cd redis-*
make
make install
