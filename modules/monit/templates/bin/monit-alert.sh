#!/bin/bash
set -e

fail() { echo "Error: ${1}" 1>&2; exit 1; }

TYPE=${1}
SOURCE="/etc/monit/templates/alert-${TYPE}"
DEST="/etc/monit/conf.d/alert"

if ! (test -e "${SOURCE}"); then
  fail "Source template not found: ${SOURCE}"
fi

rm -f ${DEST}
ln -s ${SOURCE} ${DEST}

function checkMonitHasReloaded { monit summary | grep -q 'uptime: 0m'; }
export -f checkMonitHasReloaded
RELOAD_CHECK_BEFORE=$(checkMonitHasReloaded)$?

monit reload

if [[ 0 != ${RELOAD_CHECK_BEFORE} ]]; then
  timeout --signal=9 1 bash -c "while ! (checkMonitHasReloaded); do sleep 0.05; done"
else
  echo 'Cannot check whether monit properly reloaded, sleeping for 1 second...'
  sleep 1
fi
