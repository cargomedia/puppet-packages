#!/bin/sh -e

VERSION_PATH=/usr/local/WowzaStreamingEngine/lib/lib-versions/json-simple-<%= @version %>.jar
LIB_PATH=/usr/local/WowzaStreamingEngine/lib/json-simple.jar
curl -sL http://json-simple.googlecode.com/files/json-simple-<%= @version %>.jar > $VERSION_PATH

rm -f $LIB_PATH
ln -s $VERSION_PATH $LIB_PATH
