#!/bin/bash -e

while true; do
  /var/lib/satis/satis/bin/satis --no-interaction build ${1} ${2}
  sleep 60
done
