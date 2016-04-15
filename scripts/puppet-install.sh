#!/bin/bash
set -e
cd /tmp/
if [ "$EUID" != "0" ]; then
	echo "This script must be run as root." 1>&2;
	exit 1;
fi

if (which dpkg-query && ! dpkg-query --show 'lsb-release'); then
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

elif (uname | grep -q 'Darwin'); then
	function install_dmg() {
		local name="$1"
		local url="$2"
		local dmg_path=$(mktemp -t ${name}-dmg)

		curl -sLo ${dmg_path} ${url}

		local plist_path=$(mktemp -t puppet-bootstrap)
		hdiutil attach -plist ${dmg_path} > ${plist_path}
		mount_point=$(grep -E -o '/Volumes/[-.a-zA-Z0-9]+' ${plist_path})

		pkg_path=$(find ${mount_point} -name '*.pkg' -mindepth 1 -maxdepth 1)
		installer -pkg ${pkg_path} -target / >/dev/null

		hdiutil eject ${mount_point} >/dev/null
	}

	install_dmg "Facter" "http://downloads.puppetlabs.com/mac/facter-1.7.1.dmg"
	install_dmg "Puppet" "http://downloads.puppetlabs.com/mac/puppet-3.2.1.dmg"

else
	echo 'Your operating system is not supported' 1>&2
	exit 1
fi
