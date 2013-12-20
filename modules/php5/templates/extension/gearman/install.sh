#!/bin/bash -e

curl -sL http://pecl.php.net/get/gearman-<%= @version %>.tgz | tar -xzf -
cd gearman-<%= @version %>
phpize
./configure
make
make install
