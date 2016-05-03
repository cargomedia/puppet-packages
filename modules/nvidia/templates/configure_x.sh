#!/bin/bash -e

# NOTA BENE: this is expected to run AFTER the reboot from apt-get install nvidia-drivers or
# after removing nouveau modules manually

MODESETTING_PATH=/usr/lib/xorg/modules/drivers/modesetting_drv.so
MODESETTING_BACKUP_PATH=/usr/lib/xorg/modules/drivers/modesetting_drv.so.bak
XORG_PATH=/etc/X11/xorg.conf
XORG_BACKUP_PATH=/etc/X11/xorg.conf.puppet-nvidia-module

echo "Step 1: Disable modesetting driver, it breaks Xorg -configure"
if [ -e $MODESETTING_PATH ]; then
  mv $MODESETTING_PATH $MODESETTING_BACKUP_PATH
fi

echo "Step 2: Backup xorg.conf file if exists"
if [ -e $XORG_PATH ]; then
  mv $XORG_PATH $XORG_BACKUP_PATH
fi

echo "Step 3: Auto-configure with X's own means"
nvidia-xconfig

echo "Step 4: Restore modesetting driver so it doesn't break the updates"
if [ -e $MODESETTING_BACKUP_PATH ]; then
  mv $MODESETTING_BACKUP_PATH $MODESETTING_PATH
fi
