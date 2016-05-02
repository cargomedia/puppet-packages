#!/bin/bash -e

curl -Ls http://apt.puppetlabs.com/puppetlabs-release-pc1-<%= @lsbdistcodename %>.deb > puppetlabs-release-pc1.deb
dpkg -i puppetlabs-release-pc1.deb
apt-get update
