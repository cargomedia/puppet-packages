#!/bin/bash -e

for i in $(seq $(arcconf getversion | awk '/^Controllers found:.*$/{print $3}'));
do
	DEVICES=$(arcconf getconfig $i PD | perl -e '
	foreach (join("", <STDIN>) =~ /(Device #\d+.+?MaxCache Assigned[^\n]*)/sg) {
	  if ($_ !~ /Write Cache\s*:\s*Disabled/ && $_ =~ /Reported Channel,Device\(T:L\)\s*:\s*(\d+),(\d+)\(\d+:\d+\)/) {
	  print "$1 $2\n";
	  }
	}')
    for DEVICE in $DEVICES; do
        CHANNEL=$(echo $DEVICE | awk "{print $1}")
        ID=$(echo $DEVICE | awk "{print $2}")
        set +e
        OUT=$(arcconf SETCACHE $i DEVICE ${CHANNEL} ${ID} wt)
        STATUS=$?
        set -e
        if [ $STATUS -gt 0 ] && [ -z "$(echo $OUT | grep 'same as the old')" ]; then
            echo $OUT
            exit $STATUS
        fi
    done
done
