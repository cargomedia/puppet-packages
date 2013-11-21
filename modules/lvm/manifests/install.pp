class lvm::install (
  $physicalDevices = [],
  $logicalVolumeName = undef,
  $volumeGroupName = $lvm::params::volumeGroupName,
  $logicalVolumeSize = $lvm::params::logicalVolumeSize,
  $logicalVolumeFilesystem = $lvm::params::logicalVolumeFilesystem,
  $logicalVolumeMountpoint = $lvm::params::logicalVolumeMountpoint,
  $expandTools = $lvm::params::expandTools
)  inherits lvm::params {

  include 'lvm'
  include $expandTools

  if size($physicalDevices) == 0 or $logicalVolumeName == undef {
    fail('Please specify required parameters like devices and logical volume name!')
  }

  class {'lvm::package': }

  case $logicalVolumeFilesystem {
    'xfs': {
      class {'lvm::base::xfs': }
    }
    default: {
      fail("Unknown filesystem ${logicalVolumeFilesystem}")
    }
  }

  helper::script {'install lvm':
    content => template('lvm/install'),
    unless => "pvs | grep -q ${physicalDevices}",
    require => Class['lvm::package'],
  }

  if $logicalVolumeMountpoint != undef {
    class {'snmp':
      disks => ["disk ${logicalVolumeMountpoint}"],
    }

    file {$logicalVolumeMountpoint:
      ensure => directory,
    }

    mount::entry {'mount lvm':
      source => "/dev/${volumeGroupName}/${logicalVolumeName}",
      target => $logicalVolumeMountpoint,
      mount => false,
    }

    $mountBasename = file_basename($logicalVolumeMountpoint)
    monit::entry {"fs-check-${mountBasename}":
      content => template('lvm/monit'),
    }

    file {"${logicalVolumeMountpoint}/shared":
      ensure => directory,
    }
  }
}