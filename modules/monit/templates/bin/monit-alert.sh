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

function getMonitReloadCount { grep -c 'Monit reloaded' '/var/log/syslog';  }
export -f getMonitReloadCount
export MONIT_RELOAD_COUNT=$(getMonitReloadCount)
function waitForMonitReload { timeout --signal=9 $1 bash -c 'while ! (test "$(getMonitReloadCount)" != "${MONIT_RELOAD_COUNT}"); do sleep 0.05; done'; }

if (pidof monit >/dev/null); then
  kill -s SIGHUP $(pidof monit)
  waitForMonitReload 30
fi
