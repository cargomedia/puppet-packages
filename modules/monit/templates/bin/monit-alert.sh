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

function monitGetStateFileAccess { stat -c "%Y" "/root/.monit.state"; }
export -f monitGetStateFileAccess
export MONIT_STATE_FILE_ACCESS=$(monitGetStateFileAccess)
function waitForMonitStateChange { timeout --signal=9 $1 bash -c 'while ! (test "$(monitGetStateFileAccess)" != "${MONIT_STATE_FILE_ACCESS}"); do sleep 0.05; done'; }
export -f waitForMonitStateChange

monit reload

if ! (waitForMonitStateChange 5); then
  # Hard-restart monit in case it cannot reload
  /etc/init.d/monit restart

  if ! (waitForMonitStateChange 10); then
    exit 1
  fi
fi

