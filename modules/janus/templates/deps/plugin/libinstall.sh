#!/bin/sh -e

GIT_REPO='janus-gateway-<%= @name %>'
rm -rf $GIT_REPO
git clone https://github.com/cargomedia/$GIT_REPO.git
cd $GIT_REPO
git submodule update
./autogen.sh
./configure --prefix=/opt/janus
make
make install
mv -f /opt/janus/etc/janus/* /etc/janus
