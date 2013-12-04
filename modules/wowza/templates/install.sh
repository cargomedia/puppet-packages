#!/bin/sh -e

curl -sL http://www.wowza.com/downloads/WowzaMediaServer-$(echo '<%= @version %>' | tr '.' '-')/WowzaMediaServer-<%= @version %>.deb.bin > WowzaMediaServer.deb.bin
chmod +x WowzaMediaServer.deb.bin
echo yes | bash -e WowzaMediaServer.deb.bin

echo '<%= @license %>' > /usr/local/WowzaMediaServer/conf/Server.license

chown -R wowza: /usr/local/WowzaMediaServer $(readlink /usr/local/WowzaMediaServer)
chmod -R 755 $(readlink /usr/local/WowzaMediaServer)