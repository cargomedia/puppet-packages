#!/bin/sh -e

DISABLE="--disable-docs --disable-rabbitmq --disable-plugin-audiobridge --disable-plugin-recordplay --disable-plugin-sip"
DISABLE="${DISABLE} --disable-plugin-streaming --disable-plugin-videocall --disable-plugin-videoroom --disable-plugin-voicemail"

rm -rf janus-gateway /opt/janus
git clone https://github.com/meetecho/janus-gateway.git
cd janus-gateway
git checkout <%= @version %>
./autogen.sh
./configure --prefix=/opt/janus $DISABLE --enable-post-processing --enable-plugin-echotest
make
make install
mv /opt/janus/bin/janus /usr/bin
mv /opt/janus/etc/janus/* /etc/janus
