#!/bin/bash -e

STATUS=true
if ! (systemctl is-active mysql >/dev/null); then
	STATUS=false
fi
if ! (mysql --execute="show global status like 'Slave_running';" --user="${1}" --password="${2}"  | grep -q ON ); then
	STATUS=true
fi
echo "{\"mysql slave replication failure\": ${STATUS}}"
