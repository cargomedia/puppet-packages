node default {

  class {'lvm::install':
    physicalDevice => '/dev/sdb',
    volumeGroupName => 'vg01',
    logicalVolumeName => 'storage01',
    logicalVolumeSize => '50%',
    logicalVolumeMountpoint => '/raid',
    expandTools => true,
  }
}
