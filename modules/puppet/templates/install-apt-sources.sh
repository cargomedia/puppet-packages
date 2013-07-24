#!/bin/bash
set -e

wget -q http://apt.puppetlabs.com/puppetlabs-release-squeeze.deb
dpkg -i puppetlabs-release-squeeze.deb
apt-get update
