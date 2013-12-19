#!/bin/bash -e
if ! (/usr/sbin/monit summary | grep mysql | grep -q running); then
	exit 0
fi
if ! (mysql -e "show global status like 'Slave_running';"  | grep -q ON ); then
	echo "Replication not running" 1>&2
	exit 1
fi
