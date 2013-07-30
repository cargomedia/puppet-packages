#!/bin/bash
set -e

curl -sL http://download.openx.org/openx-<%= @version %>.tar.gz > openx.tar.gz
tar -zxvf openx.tar.gz
cp -R openx-<%= @version %> /var/openx
chown -R www-data: /var/openx
