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
function monitCheckHasReloaded { test "$(monitGetStateFileAccess)" != "${MONIT_STATE_FILE_ACCESS}"; }
export -f monitCheckHasReloaded

monit reload

if ! (timeout --signal=9 5 bash -c "while ! (monitCheckHasReloaded); do sleep 0.05; done"); then
  # Hard-restart monit in case it cannot reload
  /etc/init.d/monit restart
fi
