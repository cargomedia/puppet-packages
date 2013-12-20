#!/bin/bash -e

curl -L 'http://www.percona.com/redir/downloads/percona-toolkit/<%= @version_nobuild %>/deb/percona-toolkit_<%= @version %>_all.deb' > percona-toolkit.deb
dpkg --force-depends -i percona-toolkit.deb
apt-get -qqyf install
