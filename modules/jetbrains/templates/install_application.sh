#!/bin/bash -e

curl -L <%= @download_url %> > <%= @name %>.zip
unzip <%= @name %>.zip -d <%= @name %>-<%= @version %>.<%= @build %>
cp -R <%= @name %>-<%= @version %>.<%= @build %>/*/* <%= @home_path %>/
echo <%= @version %>.<%= @build %> > <%= @home_path %>/<%= @name %>.version
