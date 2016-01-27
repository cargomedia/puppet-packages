#!/bin/bash -e

curl -sL https://pecl.php.net/get/SPL_Types-<%= @version %>.tgz | tar -xzf -
cd SPL_Types-<%= @version %>
phpize
./configure
make
make install
