#!/bin/bash
set -e
cd /tmp/
if [ "$EUID" != "0" ]; then
	echo "This script must be run as root." 1>&2;
	exit 1;
fi

if (which puppet >/dev/null); then
  exit 0
fi

OS_RELEASE_ID=$(. /etc/os-release; echo $ID)
case ${OS_RELEASE_ID} in

  "debian"|"ubuntu")
    if ! (which lsb_release >/dev/null); then
      apt-get -o Acquire::ForceIPv4=true update
      apt-get install -qy lsb-release
    fi

    LSB_CODENAME=$(lsb_release --codename | sed 's/Codename:\t//')
    wget -q http://apt.puppetlabs.com/puppetlabs-release-pc1-${LSB_CODENAME}.deb -O puppetlabs-release-pc1.deb
    dpkg -i puppetlabs-release-pc1.deb
    rm puppetlabs-release-pc1.deb
    apt-get -o Acquire::ForceIPv4=true update
    apt-get install -qy puppet-agent

    binaries=( puppet facter mco hiera )
    for binary in ${binaries[@]}; do
      binary_dest="/usr/bin/${binary}"
      rm -f "${binary_dest}"
      ln -s "/opt/puppetlabs/bin/${binary}" "${binary_dest}"
    done
    ;;

  *)
    echo "Your operating system (${OS_RELEASE_ID}) is not supported" 1>&2
    exit 1

esac
