#!/bin/sh -e

curl -sL http://www.wowza.com/downloads/WowzaMediaServer-$(echo '<%= @version %>' | tr '.' '-')/WowzaMediaServer-<%= @version %>.deb.bin > WowzaMediaServer.deb.bin
chmod +x WowzaMediaServer.deb.bin
echo yes | bash -e WowzaMediaServer.deb.bin

echo '<%= @license %>' > /usr/local/WowzaMediaServer/conf/Server.license

#cp -r /usr/local/WowzaMediaServer-custominstall/* /usr/local/WowzaMediaServer/
#rm -rf /usr/local/WowzaMediaServer-custominstall

mkdir -p <%= @working_dir %>/applications/videochat
mkdir -p <%= @working_dir %>/conf
mkdir -p <%= @working_dir %>/content
chown -R wowza: /usr/local/WowzaMediaServer $(readlink /usr/local/WowzaMediaServer)
chown -Rf wowza: <%= @working_dir %>
chmod -R 755 $(readlink /usr/local/WowzaMediaServer)
