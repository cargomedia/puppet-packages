class lvm::params {

  $volumeGroupName = $::volumeGroupName ? {
    undef => 'vg01',
    default => $::volumeGroupName,
  }

  $logicalVolumeFilesystem = $::logicalVolumeFilesystem ? {
    undef => 'xfs',
    default => $::logicalVolumeFilesystem,
  }

  $logicalVolumeSize = $::logicalVolumeSize ? {
    undef => '90%',
    default => $::logicalVolumeSize,
  }

  $logicalVolumeMountpoint = $::logicalVolumeMountpoint ? {
    undef => undef,
    default => $::logicalVolumeMountpoint,
  }

  $logicalVolumeExportpoint = $::logicalVolumeExportpoint ? {
    undef => undef,
    default => $::logicalVolumeMountpoint,
  }

  $expandTools = $::expandTools ? {
    undef => [],
    default => $::expandTools,
  }
}