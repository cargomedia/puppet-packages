#!/bin/bash
set -e
PUPPET_REPO=$1
bash <(curl -Ls https://raw.github.com/cargomedia/puppet-packages/master/scripts/puppet-install-agent.sh ${PUPPET_REPO})

if (test -f /etc/debian_version && cat /etc/debian_version | grep -q '^6\.'); then
	apt-get install -y puppetmaster

else
	echo 'Your operating system is not supported' 1>&2
	exit 1
fi
