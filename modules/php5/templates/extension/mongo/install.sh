#!/bin/bash -e

curl -sL https://github.com/mongodb/mongo-php-driver-legacy/archive/<%= @version %>.tar.gz | tar -xzf -
cd mongo-php-driver-legacy-<%= @version %>/
phpize
./configure
make
make install
