node default {

  class {'lvm::install':
    physicalDevices => ['/dev/sdb'],
    volumeGroupName => 'vg01',
    logicalVolumeName => 'storage01',
    logicalVolumeSize => '50%',
  }

}