#!/bin/bash -e

apt-get -qy install libstdc++5
wget -q http://download.adaptec.com/raid/storage_manager/asm_linux_x64_v7_30_18837.tgz
tar -xzf asm_linux_x64_v7_30_18837.tgz
mv cmdline/arcconf /usr/local/bin
