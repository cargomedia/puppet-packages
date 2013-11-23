#!/bin/bash -e

curl -sL "http://production.cf.rubygems.org/rubygems/rubygems-<%= @version %>.zip" > gems.zip
unzip gems.zip
cd rubygems-<%= @version %>
ruby setup.rb --no-format-executable
