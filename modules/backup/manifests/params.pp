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

  $rdiff_options = $::rdiff_options ? {
    undef => '--no-file-statistics --no-compare-inode',
    default => $::rdiff_options,
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