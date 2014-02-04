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

function failAndRestart {
	echo $1
	if [ -x /etc/init.d/nfs-kernel-server ] && (which monit >/dev/null); then monit restart nfs-server; fi
	exit 1
}

if !(grep -q "[[:space:]]${mount}[[:space:]]" /proc/mounts); then
	echo "Mountpoint not mounted: $mount - remounting..."
	runCommandWithTimeout 5 "mount $mount"
	if [ $? -gt 0 ]; then
		failAndRestart "Failed to remount!"
	fi
	echo "Done."
fi
runCommandWithTimeout 5 "testFile=\$(mktemp --tmpdir=${mount}) && rm -f \$testFile"
if [ $? -gt 0 ]; then
	echo "Cannot write to mountpoint: $mount - remounting..."
	umount -l $mount
	runCommandWithTimeout 5 "mount $mount"
	if [ $? -gt 0 ]; then
		failAndRestart "Failed to remount!"
	fi
	echo "Done."
fi
