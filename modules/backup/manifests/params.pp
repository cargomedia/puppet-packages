class backup::params {

  $type = $::type ? {
    undef => 'rdiff',
    default => $::type,
  }

  $host = $::host ? {
    undef => 'localhost',
    default => $::host,
  }

  $volume = $::volume ? {
    undef => undef,
    default => $::volume,
  }

  $source = $::source ? {
    undef => '/raid-backup',
    default => $::source,
  }

  $destination = $::destination ? {
    undef => undef,
    default => $::destination,
  }

  $options = $::options ? {
    undef => '--no-eas --no-file-statistics --no-carbonfile --no-acls --no-compare-inode',
    default => $::options,
  }

  $checkEnable = $::checkEnable ? {
    undef => true,
    default => $::checkEnable,
  }

  $checkDestinations = $::checkDestination ? {
    undef => undef,
    default => $::checkDestination,
  }
}