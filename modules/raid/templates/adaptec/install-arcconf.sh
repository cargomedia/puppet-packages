#!/bin/bash -e
apt-get -qy install libstdc++5
curl -L http://download.adaptec.com/raid/storage_manager/asm_linux_x64_v<%= @version.scan(/[\d]+/).join('_') %>.tgz | tar -xzf -
mv cmdline/arcconf /usr/local/bin
