#!/bin/sh -e

cd /opt/janus-gateway
./autogen.sh
./configure --prefix=/usr --disable-docs --disable-rabbitmq
make
make install
