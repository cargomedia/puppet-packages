#!/bin/bash -e

curl -sL http://mmonit.com/monit/dist/monit-<%= @version %>.tar.gz > monit.tar.gz
tar -xvf monit.tar.gz
cd monit-*
./configure --without-pam
make
make install
