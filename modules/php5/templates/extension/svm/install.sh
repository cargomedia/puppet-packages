#!/bin/bash -e

curl -sL https://github.com/ianbarber/php-svm/archive/<%= @version %>.tar.gz | tar -xzf -
cd php-svm-<%= @version %>
phpize
./configure
make
make install
