#!/bin/bash
set -e
if ! (which git > /dev/null); then
  apt-get install -qy git
fi

REPO_URL=${1}
NAME=$(echo "${REPO_URL}" | sed 's/.*[:/]\([^:/]*\)\.git$/\1/')
REPO_PATH="/etc/puppet/repos/${NAME}"
MODULE_PATH="${REPO_PATH}/modules"
CONFIG="$(puppet agent --configprint confdir)/puppet.conf"

mkdir -p /etc/puppet/repos/
git clone "${REPO_URL}" "${REPO_PATH}"

echo "* * * * * root cd '${REPO_PATH}' && git pull --quiet" > "/etc/cron.d/puppet-repo-${NAME}"
perl -pi -e "\$modulePath = '${MODULE_PATH}'; s/^modulepath = (.*)$/modulepath = \$1:\$modulePath/" ${CONFIG}
