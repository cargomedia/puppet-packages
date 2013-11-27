#!/bin/bash -e

curl -sL http://pecl.php.net/get/APC-<%= @version %>.tgz | tar -xzf -
cd APC-<%= @version %>/
phpize
./configure <%= @configureParams %>
make
make install
