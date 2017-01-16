#!/bin/bash

for fs in ext2 ext3 ext4; do
  for i in $(findmnt -lno source -t ${fs}); do
    if ! (tune2fs -c 0 -i 0 ${i}); then
      rm -rf /var/local/nofsck
    else
      touch /var/local/nofsck
    fi
  done;
done;
