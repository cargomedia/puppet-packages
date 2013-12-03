#!/bin/bash -e

rm -rf /tmp/backup-db

/usr/sbin/monit unmonitor mysql
/etc/init.d/mysql stop >/dev/null
cp -a <%= @source %> /tmp/backup-db
/etc/init.d/mysql start >/dev/null
/usr/sbin/monit monitor mysql

ssh root@<%= @host %> "mkdir -p <%= @destination %>"
rdiff-backup <%= @options %> /tmp/backup-db root@<%= @host %>::<%= @destination %> >/dev/null
rdiff-backup --remove-older-than 4W --force root@<%= @host %>::<%= @destination %> >/dev/null

rm -rf /tmp/backup-db
