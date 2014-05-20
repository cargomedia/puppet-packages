#!/bin/bash -e

ARCCONF_ZIPFILE='arcconf_v<%= @version.gsub(/\./, "_") %>_<%= @revision %>.zip'
wget -q http://download.adaptec.com/raid/storage_manager/$ARCCONF_ZIPFILE
unzip $ARCCONF_ZIPFILE
cp linux_x64/cmdline/arcconf /usr/sbin/arcconf
