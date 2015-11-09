#!/bin/sh -e

rm -rf janus-gateway
git clone https://github.com/meetecho/janus-gateway.git
cd janus-gateway
./autogen.sh
./configure --prefix=/opt/janus --disable-docs --disable-rabbitmq --enable-post-processing
make
make install
mv /opt/janus/bin/janus /usr/bin
mv /opt/janus/etc/janus/* /etc/janus
