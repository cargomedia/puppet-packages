#!/bin/bash
set -e

if !(which sgdisk >/dev/null); then
  apt-get update
  apt-get install -qy gdisk
fi

if !(grep -q '/dev/sdb1' /proc/mounts); then
  sgdisk -n 1:$STARTSECTOR:$ENDSECTOR /dev/sdb
  mkfs.ext4 -O ^has_journal -m 0 /dev/sdb1
  mkdir -p /tmp/proxy-cache
  mount /dev/sdb1 /tmp/proxy-cache -o relatime
  chown -R proxy /tmp/proxy-cache
fi
