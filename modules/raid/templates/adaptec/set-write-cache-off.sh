#!/bin/bash -e
DEVICES=$(/usr/local/sbin/arcconf-write-cache-on-devices.pl)
for DEVICE in $DEVICES; do
	CONTROLLER=$(echo ${DEVICE} | awk "{print $1}")
	CHANNEL=$(echo ${DEVICE} | awk "{print $2}")
	ID=$(echo ${DEVICE} | awk "{print $3}")
	set +e
	OUT=$(arcconf SETCACHE ${CONTROLLER} DEVICE ${CHANNEL} ${ID} wt)
	STATUS=$?
	set -e
	if [ $STATUS -gt 0 ] && [ -z "$(echo $OUT | grep 'same as the old')" ]; then
		echo $OUT
		exit $STATUS
	fi
done
