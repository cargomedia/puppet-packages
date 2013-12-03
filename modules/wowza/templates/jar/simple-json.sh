#!/bin/sh -e

curl -sL http://json-simple.googlecode.com/files/json-simple-<%= @version %>.jar > /usr/local/WowzaMediaServer/lib/json-simple-<%= @version %>.jar
