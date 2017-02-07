#!/bin/bash -e

curl -L https://download.jetbrains.com/hub/<%= @version %>/hub-ring-bundle-<%= @version %>.<%= @build %>.zip > hub-ring-bundle.zip
unzip hub-ring-bundle.zip
cp -R hub-ring-bundle-<%= @version %>.<%= @build %>/* <%= @home_path %>/
echo <%= @version %>.<%= @build %> > <%= @home_path %>/version.docker.image
