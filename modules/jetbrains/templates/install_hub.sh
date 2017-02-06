#!/bin/bash

cd /tmp
curl -L https://download.jetbrains.com/hub/<%= @version %>/hub-ring-bundle-<%= @version %>.<%= @build %>.zip > hub-ring-bundle.zip
unzip hub-ring-bundle.zip
cp -R hub-ring-bundle-<%= @version %>.<%= @build %>/* /usr/local/hub/
echo <%= @version %>.<%= @build %> > /usr/local/hub/version.docker.image
rm -f hub-ring-bundle.zip
