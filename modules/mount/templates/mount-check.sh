#!/bin/bash

mount=$1
function runCommandWithTimeout {
	command=$2
	timeout --signal=9 $1 sh -c "$command"
	if [ $? -eq 0 ]; then
		return 0
	else
		return 1
	fi
}

if !(grep -q "[[:space:]]${mount}[[:space:]]" /proc/mounts); then
	echo "Mountpoint not mounted: $mount - remounting..."
	runCommandWithTimeout 5 "mount $mount"
	if [ $? -gt 0 ]; then
		echo "Failed to remount!"
		exit 1
	fi
	echo "Done."
fi
runCommandWithTimeout 5 "testFile=\$(mktemp --tmpdir=${mount}) && rm -f \$testFile"
if [ $? -gt 0 ]; then
	echo "Cannot write to mountpoint: $mount - remounting..."
	umount -l $mount
	runCommandWithTimeout 5 "mount $mount"

	if [ $? -gt 0 ]; then
		echo "Failed to remount!"
		exit 1
	fi
	echo "Done."
fi
