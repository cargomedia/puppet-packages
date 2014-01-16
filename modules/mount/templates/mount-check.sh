#!/bin/bash

mount=$1
function runCommandWithTimeout {
	command=$2
	read -t$1 result < <(sh -c "($command)>/dev/null && echo ok")
	if [ $? -eq 0 ] && [ $result == "ok" ]; then
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

out=$(timeout --kill-after=1 --signal=9 5 sh -c 'm=$(mktemp --tmpdir=${mount}) && rm -f ${m}')
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
