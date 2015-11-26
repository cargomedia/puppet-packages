node default {

  package { ['mount', 'util-linux']:
    ensure   => present,
    provider => 'apt',
  }
  ->

  helper::script { 'Setup temporary loop device':
    content => 'TMP=$(mktemp);dd if=/dev/zero of=$TMP bs=100 count=1M;losetup /dev/loop0 $TMP',
    unless  => 'lsblk | grep -q loop0',
  }
  ->

  class { 'lvm::install':
    physicalDevice          => '/dev/loop0',
    volumeGroupName         => 'vg01',
    logicalVolumeName       => 'storage01',
    logicalVolumeSize       => '50%',
    logicalVolumeMountpoint => '/raid',
    expandTools             => true,
  }
}
