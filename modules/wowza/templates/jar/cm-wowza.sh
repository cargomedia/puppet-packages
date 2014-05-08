#!/bin/sh -e

VERSION_PATH=/usr/local/WowzaStreamingEngine/lib/lib-versions/ch.cargomedia.wms-<%= @version %>.jar
LIB_PATH=/usr/local/WowzaStreamingEngine/lib/ch.cargomedia.wms.jar
curl -sL https://github.com/cargomedia/CM-wowza/releases/download/v<%= @version %>/ch.cargomedia.wms.jar > $VERSION_PATH

rm -f $LIB_PATH
ln -s $VERSION_PATH $LIB_PATH
