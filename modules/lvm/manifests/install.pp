class lvm::install (
  $physicalDevice,
  $logicalVolumeName,
  $volumeGroupName = $lvm::params::volumeGroupName,
  $logicalVolumeSize = $lvm::params::logicalVolumeSize,
  $logicalVolumeFilesystem = $lvm::params::logicalVolumeFilesystem,
  $logicalVolumeMountpoint = $lvm::params::logicalVolumeMountpoint,
  $expandTools = $lvm::params::expandTools
)  inherits lvm::params {

  include 'lvm'

  class {'lvm::package': }

  case $logicalVolumeFilesystem {
    'xfs': {
      class {'lvm::base::xfs': }

      cron {'xfs-maintenance':
        command => '/usr/sbin/xfs_fsr >/dev/null',
        user => 'root',
        minute => 30,
        hour => 2,
        require => Class['lvm::base::xfs'],
      }

      if $expandTools == true {
        class {'lvm::expand::raid::adaptec':
          logicalVolumeName => $logicalVolumeName,
          volumeGroupName => $volumeGroupName,
        }
      }
    }
    default: {
      fail("Unknown filesystem ${logicalVolumeFilesystem}")
    }
  }

  helper::script {'install lvm':
    content => template('lvm/install'),
    unless => "lvs | grep -q ${logicaVolumeName}",
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