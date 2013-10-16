#!/bin/bash -e
if !(test -x /usr/local/bin/arcconf); then
	exit 0
fi

DEVICES=$(arcconf getconfig 1 PD | awk '/Device is a Hard drive/,/Reported Location/' | grep 'T:L' | awk '{print $4}' | cut -d '(' -f 1)
for DEVICE in $DEVICES; do
	CHANNEL=$(echo $DEVICE | cut -d ',' -f1)
	ID=$(echo $DEVICE | cut -d ',' -f2)
	set +e
	OUT=$(arcconf SETCACHE 1 DEVICE ${CHANNEL} ${ID} wt)
	STATUS=$?
	set -e
	if [ $STATUS -gt 0 ] && [ -z "$(echo $OUT | grep 'same as the old')" ]; then
		echo $OUT
		exit $STATUS
	fi
done
