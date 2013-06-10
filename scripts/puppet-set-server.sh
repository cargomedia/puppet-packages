#!/bin/sh -e
MASTER_SERVER=$1
CONFIG="$(puppet agent --configprint confdir)/puppet.conf"

perl -pi -e "\$masterServer = '${MASTER_SERVER}'; s/^server = .*$/server = \$masterServer/" ${CONFIG}
