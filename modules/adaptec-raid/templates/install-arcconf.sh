#!/bin/bash -e
lspci | grep -qi 'adaptec.*raid' || exit 0

if !(test -x /usr/local/bin/arcconf && /usr/local/bin/arcconf | grep -iq 'Version 7.30') then
	apt-get -qy install libstdc++5
	wget -q http://download.adaptec.com/raid/storage_manager/asm_linux_x64_v7_30_18837.tgz
	unp asm_linux_x64_v7_30_18837.tgz
	mv cmdline/arcconf /usr/local/bin
fi
