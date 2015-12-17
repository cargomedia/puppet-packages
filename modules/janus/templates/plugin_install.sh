#!/bin/sh -e

GIT_REPO='janus-gateway-<%= @name %>'
JANUS_VERSION='<%= @janus_version %>'

rm -rf $GIT_REPO
if (git clone --recursive https://github.com/cargomedia/$GIT_REPO.git | grep -vqE "^Submodule+.+janus-gateway.+$JANUS_VERSION'"); then
    cd $GIT_REPO/janus-gateway
    git checkout $JANUS_VERSION
    cd -
fi
cd $GIT_REPO
./autogen.sh
./configure --prefix=/opt/janus
make
make install
mv -f /opt/janus/etc/janus/* /etc/janus
