#!/bin/bash -e

curl -sL "<%= @url %>" > vagrant.deb
for i in $(find /usr /opt /home /var -ipath '*/.vagrant.d'); do
    rm -rf "${i}"
done
dpkg -i --force-confold vagrant.deb
ln -sf /opt/vagrant/bin/vagrant /usr/local/bin/vagrant
