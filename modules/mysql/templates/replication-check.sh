#!/bin/bash -e
if ! (systemctl is-active mysql >/dev/null); then
	exit 0
fi
if ! (mysql -e "show global status like 'Slave_running';"  | grep -q ON ); then
	echo "Replication not running" 1>&2
	exit 1
fi
