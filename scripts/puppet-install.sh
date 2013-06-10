#!/bin/bash -e
if [ "$EUID" != "0" ]; then
	echo "This script must be run as root." 1>&2;
	exit 1;
fi

if (uname -a | grep -q 'debian-6-'); then
	wget -q http://apt.puppetlabs.com/puppetlabs-release-squeeze.deb
	dpkg -i puppetlabs-release-squeeze.deb
	apt-get update
	apt-get install puppet
fi

if (uname | grep -q 'Darwin'); then
	function install_dmg() {
		local name="$1"
		local url="$2"
		local dmg_path=$(mktemp -t ${name}-dmg)

		curl -sLo ${dmg_path} ${url} 2>/dev/null

		local plist_path=$(mktemp -t puppet-bootstrap)
		hdiutil attach -plist ${dmg_path} > ${plist_path}
		mount_point=$(grep -E -o '/Volumes/[-.a-zA-Z0-9]+' ${plist_path})

		pkg_path=$(find ${mount_point} -name '*.pkg' -mindepth 1 -maxdepth 1)
		installer -pkg ${pkg_path} -target / >/dev/null

		hdiutil eject ${mount_point} >/dev/null
	}

	install_dmg "Facter" "http://downloads.puppetlabs.com/mac/facter-1.7.1.dmg"
	install_dmg "Puppet" "http://downloads.puppetlabs.com/mac/puppet-3.2.1.dmg"

	curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/resources/puppet-agent.plist > /Library/LaunchDaemons/com.puppetlabs.puppet.plist
	chown root:wheel /Library/LaunchDaemons/com.puppetlabs.puppet.plist
	chmod 644 /Library/LaunchDaemons/com.puppetlabs.puppet.plist
	launchctl load -w /Library/LaunchDaemons/com.puppetlabs.puppet.plist
fi

CONFIG="$(puppet agent --configprint confdir)/puppet.conf"
curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/resources/puppet.conf > ${CONFIG}
