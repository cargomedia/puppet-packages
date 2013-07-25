#!/bin/bash
set -e

curl -Ls http://apt.puppetlabs.com/puppetlabs-release-squeeze.deb > puppetlabs-release-squeeze.deb
dpkg -i puppetlabs-release-squeeze.deb
apt-get update
