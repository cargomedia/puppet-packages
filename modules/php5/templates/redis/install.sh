#!/bin/bash
set -e

curl -L https://github.com/nicolasff/phpredis/archive/<%= @version %>.tar.gz | tar -xzf -
cd phpredis-*
phpize
./configure
make
make install
