#!/bin/bash -e

# NOTA BENE: this is expected to run AFTER the reboot from apt-get install nvidia-drivers or
# after removing nouveau modules manually

# unload nouveau module from kernel

echo "Step 1: Disable modesetting driver, it breaks Xorg -configure"
mv /usr/lib/xorg/modules/drivers/modesetting_drv.so /usr/lib/xorg/modules/drivers/modesetting_drv.so~

echo "Step 2: Auto-configure with X's own means"
X -configure

echo "Step 3: Move the file back to normal place"
mv -i ~/xorg.conf.new /etc/X11/xorg.conf

echo "Step 4: Restore modesetting driver so it doesn't break the updates"
mv /usr/lib/xorg/modules/drivers/modesetting_drv.so~ /usr/lib/xorg/modules/drivers/modesetting_drv.so
