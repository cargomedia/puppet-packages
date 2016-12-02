#!/bin/bash -e

curl -sL https://github.com/mongodb/mongo-php-driver/releases/download/<%= @version %>/mongodb-<%= @version %>.tgz | tar -xzf -
cd mongodb-<%= @version %>/
phpize
./configure
make all -j 5
make install
