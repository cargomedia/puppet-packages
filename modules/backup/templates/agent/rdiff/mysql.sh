#!/bin/sh

set -e

HOST="<%= @host %>"
RDIFF_BACKUP_OPTS='<%= @options %>'

rm -rf /tmp/backup-db
/usr/sbin/monit unmonitor mysql
/etc/init.d/mysql stop >/dev/null
cp -a <%= @source %> /tmp/backup-db
/etc/init.d/mysql start >/dev/null
/usr/sbin/monit monitor mysql

ssh root@$HOST "mkdir -p <%= @destination %>"
rdiff-backup ${RDIFF_BACKUP_OPTS} /tmp/backup-db root@$HOST::<%= @destination %> >/dev/null
rdiff-backup --remove-older-than 4W --force root@$HOST::<%= @destination %> >/dev/null

rm -rf /tmp/backup-db
