class lvm::install (
  $physicalDevices = [],
  $logicalVolumeName = undef,
  $volumeGroupName = $lvm::params::volumeGroupName,
  $logicalVolumeSize = $lvm::params::logicalVolumeSize,
  $logicalVolumeFilesystem = $lvm::params::logicalVolumeFilesystem
)  inherits lvm::params {

  include 'lvm'
  include 'nfs'

  if size($physicalDevices) == 0 or $logicalVolumeName == undef {
    fail("Please specify required parameters like devices and logical volume name!")
  }

  case $logicalVolumeFilesystem {
    'xfs': {
      include 'lvm::base::xfs'
    }
    default: {
      fail("Unknown filesystem ${logicalVolumeFilesystem}")
    }
  }

  file {'/root/bin/lvm-install.sh':
    ensure => file,
    content => template('lvm/install'),
  }

  file {'/root/bin/lvm-mount.sh':
    ensure => file,
    content => template('lvm/mount'),
  }

}