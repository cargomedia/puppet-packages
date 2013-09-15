#!/bin/bash
curl -sL http://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-<%= @version %>.deb > elasticsearch.deb
dpkg -i --force-confold elasticsearch.deb
