node default {

  class {'lvm::install':
    physicalDevice => '/dev/sda5',
    volumeGroupName => 'vg01',
    logicalVolumeName => 'storage01',
    logicalVolumeSize => '50%',
    logicalVolumeMountpoint => '/raid',
    expandTools => true,
  }
}