#!/bin/bash -e

curl -sL http://download.openx.org/openx-<%= @version %>.tar.gz > openx.tar.gz
tar -zxvf openx.tar.gz
rsync -a openx-<%= @version %>/ /var/openx
chown -R www-data: /var/openx
