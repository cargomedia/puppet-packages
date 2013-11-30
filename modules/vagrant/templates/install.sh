#!/bin/bash -e

curl -sL "<%= @url %>" > vagrant.deb
dpkg -i --force-confold vagrant.deb
ln -sf /opt/vagrant/bin/vagrant /usr/local/bin/vagrant
