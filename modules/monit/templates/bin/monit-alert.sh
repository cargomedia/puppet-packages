#!/bin/sh
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
monit reload
