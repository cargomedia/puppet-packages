#!/bin/sh -e

curl -sL http://downloads.sourceforge.net/project/flexjson/flexjson/flexjson%20<%= @version %>/flexjson-<%= @version %>.tar.gz > flexjson.tar.gz
tar -xvf flexjson.tar.gz
mv flexjson-<%= @version %>/flexjson-<%= @version %>.jar /usr/local/WowzaMediaServer/lib/