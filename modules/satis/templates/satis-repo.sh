#!/bin/bash -e

satis_ok=0
output_file="/tmp/satis-repo-$3.err"

while [ $satis_ok == '0' ]; do
  /var/lib/satis/satis/bin/satis --no-interaction build $1 $2 >${output_file} 2>&1
  satis_ok=$?
  if [ $satis_ok != '0' ]; then
    # if satis errored, check if output contains a TransportException towards github.com (Auth, timeout, 5xx, etc.)
    grep -A2 TransportException ${output_file} | grep -q github.com
    # if yes, pretend all is ok
    satis_ok=$?
  fi
  sleep 60
done
