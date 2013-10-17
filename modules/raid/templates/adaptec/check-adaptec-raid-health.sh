#!/bin/bash

for i in $(seq $(arcconf getversion | awk '/^Controllers found:.*$/{print $3}'));
do
    OUT=$(/usr/local/bin/arcconf getconfig $i LD | grep Status | grep -vi Optimal)
    if [ $? == 0 ]; then
        echo "Controller $i: "
        echo -e "${OUT}"
    fi
done
