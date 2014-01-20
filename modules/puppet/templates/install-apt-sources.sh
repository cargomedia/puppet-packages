#!/bin/bash -e

curl -Ls http://apt.puppetlabs.com/puppetlabs-release-<%= @lsbdistcodename %>.deb > puppetlabs-release-<%= @lsbdistcodename %>.deb
dpkg -i puppetlabs-release-<%= @lsbdistcodename %>.deb
apt-get update
