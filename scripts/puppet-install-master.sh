#!/bin/bash
set -e

if (test -f /etc/debian_version && cat /etc/debian_version | grep -q '^6\.'); then
	apt-get install -y puppetmaster
else
	echo 'Your operating system is not supported' 1>&2
	exit 1
fi
