#!/bin/sh -e

curl -sL https://github.com/cargomedia/CM-wowza/releases/download/v<%= @version %>/ch.cargomedia.wms.jar > /usr/local/WowzaMediaServer/lib/ch.cargomedia.wms-<%= @version %>.jar
