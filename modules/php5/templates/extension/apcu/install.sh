#!/bin/bash -e

curl -sL http://pecl.php.net/get/apcu-<%= @version %>.tgz | tar -xzf -
cd apcu-<%= @version %>/
phpize
./configure <%= @configureParams %>
make
make install
