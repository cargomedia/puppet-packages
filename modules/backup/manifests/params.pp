class backup::params {

  $type = $::type ? {
    undef => 'rdiff',
    default => $::type,
  }

  $sourceType = $::sourceType ? {
    undef => undef,
    default => $::sourceType,
  }

  $host = $::host ? {
    undef => 'localhost',
    default => $::host,
  }

  $source = $::source ? {
    undef => undef,
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

  $cronTimeMinute = $::cronTimeMinute ? {
    undef => 0,
    default => $::cronTimeMinute,
  }

  $cronTimeHour = $::cronTimeHour ? {
    undef => 4,
    default => $::cronTimeHour,
  }

}