#!/bin/bash -e

curl -sL https://github.com/mongodb/mongo-php-driver/archive/<%= @version %>.tar.gz | tar -xzf -
cd mongo-php-driver-<%= @version %>/
phpize
./configure
make
make install
