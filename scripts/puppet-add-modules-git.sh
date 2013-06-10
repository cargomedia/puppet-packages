#!/bin/bash -e

if ! (which git); then
	apt-get install git
fi

REPO_URL=${1}
NAME=$(echo "${REPO_URL}" | sed 's/.*[:/]\([^:/]*\)\.git$/\1/')
REPO_PATH="/etc/puppet/repos/${NAME}"
MODULE_PATH="${REPO_PATH}/modules"
CONFIG="$(puppet agent --configprint confdir)/puppet.conf"

mkdir -p /etc/puppet/repos/
git clone "${REPO_URL}" "${REPO_PATH}"

echo "* * * * * cd '${REPO_PATH}' && git pull --quiet" > "/etc/cron.d/puppet-repo-${NAME}"

perl -pi -e "s/^modulepath = (.*)$/modulepath = \$1:${MODULE_PATH}/" ${CONFIG}
