#!/bin/bash -e

curl -sL http://pecl.php.net/get/stats-<%= @version %>.tgz | tar -xzf -
cd stats-<%= @version %>
phpize
./configure
make
make install
