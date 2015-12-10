#!/bin/sh -e

DISABLE="--disable-docs --disable-rabbitmq --disable-plugin-audiobridge --disable-plugin-recordplay --disable-plugin-sip"
DISABLE="${DISABLE} --disable-plugin-streaming --disable-plugin-videocall --disable-plugin-videoroom --disable-plugin-voicemail"

cd /opt/src/janus
./autogen.sh
./configure --prefix=/opt/janus $DISABLE --enable-post-processing --enable-plugin-echotest
make
make install
mv -f /opt/janus/bin/janus /usr/bin
mv -bn /opt/janus/etc/janus/* /etc/janus
