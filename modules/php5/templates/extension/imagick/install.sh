#!/bin/bash -e

curl -sL http://pecl.php.net/get/imagick-<%= @version %>.tgz | tar -xzf -
cd imagick-<%= @version %>
phpize
./configure
make
make install
