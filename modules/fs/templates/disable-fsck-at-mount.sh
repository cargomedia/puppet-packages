#!/bin/bash

for fs in ext2 ext3 ext4; do
  for i in $(findmnt -lno source -t ${fs}); do
    tune2fs -c 0 -i 0 ${i}
  done;
done;
