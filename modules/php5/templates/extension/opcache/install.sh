#!/bin/bash -e

curl -sL http://pecl.php.net/get/zendopcache-<%= @version %>.tgz | tar -xzf -
cd zendopcache-<%= @version %>/
phpize
./configure <%= @configureParams %>
make
make install
