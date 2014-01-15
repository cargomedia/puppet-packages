#!/bin/bash -e

curl -sL http://download.revive-adserver.com/revive-adserver-<%= @version %>.tar.gz > revive.tar.gz
tar -zxvf revive.tar.gz
rsync -a revive-adserver-<%= @version %>/ /var/revive
chown -R www-data: /var/revive
