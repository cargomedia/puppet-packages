#!/bin/bash
set -e
cd /tmp/
if [ "$EUID" != "0" ]; then
	echo "This script must be run as root." 1>&2;
	exit 1;
fi

if (which dpkg-query >/dev/null && ! dpkg-query --show 'lsb-release'); then
  apt-get update
  apt-get install -qy lsb-release
fi

if (which lsb_release >/dev/null && lsb_release --id | grep -qE "(Debian|Ubuntu)$"); then
	LSB_CODENAME=$(lsb_release --codename | sed 's/Codename:\t//')
	wget -q http://apt.puppetlabs.com/puppetlabs-release-pc1-${LSB_CODENAME}.deb -O puppetlabs-release-pc1.deb
	dpkg -i puppetlabs-release-pc1.deb
	rm puppetlabs-release-pc1.deb
	apt-get update
	apt-get install -qy puppet-agent

	binaries=( puppet facter mco hiera )
	for binary in ${binaries[@]}; do
	  binary_dest="/usr/bin/${binary}"
	  rm -f "${binary_dest}"
	  ln -s "/opt/puppetlabs/bin/${binary}" "${binary_dest}"
	done

else
	echo 'Your operating system is not supported' 1>&2
	exit 1
fi
