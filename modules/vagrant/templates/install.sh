#!/bin/bash -e

curl -sL "<%= @url %>" > vagrant.deb
for i in $(find /usr /opt /home /var -ipath '*/.vagrant.d'); do
    for j in $(ls -1 "${i}"); do
        if [ "${j}" != 'boxes' ]; then
            rm -rf "${i}/${j}"
        fi
    done
done
dpkg -i --force-confold vagrant.deb
ln -sf /opt/vagrant/bin/vagrant /usr/local/bin/vagrant
