#!/bin/bash
set -e
MASTER_SERVER=$1
CONFIG="$(puppet agent --configprint confdir)/puppet.conf"

perl -pi -e "s/^server = .*$/server = \${MASTER_SERVER}/" ${CONFIG}
