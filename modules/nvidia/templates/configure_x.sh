#!/bin/bash -e

XORG_PATH=/etc/X11/xorg.conf
XORG_BACKUP_PATH=/etc/X11/xorg.conf.puppet-nvidia-module

echo "Step 1: Backup xorg.conf file if exists"
if [ -e $XORG_PATH ]; then
  mv $XORG_PATH $XORG_BACKUP_PATH
fi

echo "Step 2: Auto-configure with X's own means"
nvidia-xconfig
