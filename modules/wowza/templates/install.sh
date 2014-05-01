#!/bin/sh -e

RESPONSES="yes\\n<%= @admin_user %>\\n<%= @admin_password %>\\n<%= @admin_password %>\\n<%= @license %>\\nno"

curl -sL http://www.wowza.com/downloads/WowzaStreamingEngine-$(echo '<%= @version %>' | tr '.' '-')/WowzaStreamingEngine-<%= @version %>.deb.bin > WowzaStreamingEngine.deb.bin
chmod +x WowzaStreamingEngine.deb.bin
echo $RESPONSES | ./WowzaStreamingEngine.deb.bin

chown -R wowza: /usr/local/WowzaStreamingEngine $(readlink /usr/local/WowzaStreamingEngine)
chmod -R 755 $(readlink /usr/local/WowzaStreamingEngine)
