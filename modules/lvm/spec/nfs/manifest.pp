node default {

  class {'lvm::install':
    physicalDevices => ['/dev/sda5'],
    volumeGroupName => 'vg01',
    logicalVolumeName => 'storage01',
    logicalVolumeSize => '50%',
    logicalVolumeMountpoint => '/raid',
  }
  ->

  nfs::server::export {'/shared':
    localPath => '/raid/shared',
    configuration => '*(rw,async,no_root_squash,no_subtree_check,fsid=1)',
  }
}