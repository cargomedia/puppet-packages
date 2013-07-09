#!/bin/bash
set -e
REPOSITORY=$1

curl -Ls https://raw.github.com/cargomedia/${REPOSITORY}/master/scripts/resources/puppet.conf > $(puppet agent --configprint confdir)/puppet.conf
