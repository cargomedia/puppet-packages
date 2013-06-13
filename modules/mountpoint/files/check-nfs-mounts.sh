#!/bin/bash

function runCommandWithTimeout {
	command=$2
	read -t$1 result < <(sh -c "($command)>/dev/null && echo ok")
	if [ $? -eq 0 ] && [ $result == "ok" ]; then
		return 0
	else
		return 1
	fi
}

for mount in $(cat /etc/fstab | awk '/nfs4/ {print $2}'); do
	if !(grep -q "[[:space:]]${mount}[[:space:]]" /proc/mounts); then
		echo "NFS mountpoint not mounted: $mount - remounting..."
		runCommandWithTimeout 5 "mount $mount"
		if [ $? -gt 0 ]; then
			echo "Failed to remount!"
			exit 1
		fi
		echo "Done."
	fi
	runCommandWithTimeout 5 "testFile=$(mktemp --tmpdir=$mount) && rm -f \$testFile"
	if [ $? -gt 0 ]; then
		echo "Cannot write to NFS mountpoint: $mount - remounting..."
		umount -l $mount
		runCommandWithTimeout 5 "mount $mount"
		if [ $? -gt 0 ]; then
			echo "Failed to remount!"
			exit 1
		fi
		echo "Done."
	fi
done
