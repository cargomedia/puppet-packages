#!/bin/bash -e

if [ '<%= @lsbdistcodename %>' -eq 'vivid' ]; then
	# 15.04 is only available as a PC1 (p...-candidate?) dist right now
	PUPPETLABS_REPO='puppetlabs-release-pc1'
else
	PUPPETLABS_REPO='puppetlabs-release'
fi
curl -Ls http://apt.puppetlabs.com/$PUPPETLABS_REPO-<%= @lsbdistcodename %>.deb > $PUPPETLABS_REPO-<%= @lsbdistcodename %>.deb
dpkg -i $PUPPETLABS_REPO-<%= @lsbdistcodename %>.deb
apt-get update
