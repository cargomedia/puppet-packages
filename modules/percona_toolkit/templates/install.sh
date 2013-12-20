#!/bin/bash -e
curl -L 'http://www.percona.com/redir/downloads/percona-toolkit/LATEST/deb/percona-toolkit_<%= @version %>_all.deb' > percona-toolkit.deb
dpkg --force-depends -i percona-toolkit.deb
apt-get -qqyf install
