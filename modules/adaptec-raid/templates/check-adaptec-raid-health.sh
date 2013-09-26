#!/bin/bash

lspci | grep -qi 'adaptec.*raid' || exit 0

OUT=$(/usr/local/bin/arcconf getconfig 1 LD | grep Status | grep -vi Optimal)

if [ $? == 0 ]; then
	echo $OUT
fi
