#!/bin/bash -e

curl -sL https://github.com/arnaud-lb/php-rdkafka/archive/<%= @version %>-php5.tar.gz | tar -xzf -
cd php-rdkafka-<%= @version %>-php5
phpize
./configure
make all -j 5
make install
