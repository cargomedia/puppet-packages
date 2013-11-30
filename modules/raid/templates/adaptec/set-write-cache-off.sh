#!/bin/bash -e

/usr/local/sbin/arcconf-write-cache-on-devices.pl | while read DEVICE; do
	CONTROLLER=$(echo "${DEVICE}" | cut -f 1)
	CHANNEL=$(echo "${DEVICE}" | cut -f 2)
	ID=$(echo "${DEVICE}" | cut -f 3)
	set +e
	OUT=$(arcconf SETCACHE ${CONTROLLER} DEVICE ${CHANNEL} ${ID} wt)
	STATUS=$?
	set -e
	if [ $STATUS -gt 0 ] && [ -z "$(echo $OUT | grep 'same as the old')" ]; then
		echo $OUT
		exit $STATUS
	fi
done
