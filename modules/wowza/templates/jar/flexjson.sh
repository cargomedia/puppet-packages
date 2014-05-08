#!/bin/sh -e

VERSION_PATH=/usr/local/WowzaStreamingEngine/lib/lib-versions/flexjson-<%= @version %>.jar
LIB_PATH=/usr/local/WowzaStreamingEngine/lib/flexjson.jar
curl -sL http://downloads.sourceforge.net/project/flexjson/flexjson/flexjson%20<%= @version %>/flexjson-<%= @version %>.tar.gz > flexjson.tar.gz
tar -xvf flexjson.tar.gz

mv flexjson-<%= @version %>/flexjson-<%= @version %>.jar $VERSION_PATH

rm -f $LIB_PATH
ln -s $VERSION_PATH $LIB_PATH
