#!/bin/bash -e

git clone https://github.com/hnw/php-timecop.git php-timecop
cd php-timecop
git checkout v<%= @version %>

phpize
./configure
make
make install
