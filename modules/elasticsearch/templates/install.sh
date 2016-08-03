#!/bin/bash -e
curl -sL http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-<%= @version %>.deb > elasticsearch.deb
dpkg -i --force-confold elasticsearch.deb

update-rc.d elasticsearch defaults 95 10

/etc/init.d/elasticsearch stop
