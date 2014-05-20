#!/bin/bash -e

wget -q http://download.adaptec.com/raid/storage_manager/arcconf_v1_5_20942.zip
unzip arcconf_v1_5_20942.zip
cp linux_x64/cmdline/arcconf /usr/sbin/arcconf
