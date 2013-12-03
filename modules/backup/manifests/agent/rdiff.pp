class backup::agent::rdiff (
  $sourceType = $backup::params::sourceType,
  $host = $backup::params::host,
  $source = $backup::params::source,
  $destination = $backup::params::destination,
  $options = $backup::params::rdiff_options,
  $cronTimeHour = $backup::params::cronTimeHour,
  $cronTimeMinute = $backup::params::cronTimeMinute
) inherits backup::params {

  require 'rdiff-backup'
  include 'backup'

  if ($host == undef or $source == undef or $destination == undef) {
    fail('Please specify all required params like host, source and destination.')
  }

  case $sourceType {
    'mysql': {
      $content = template('backup/agent/rdiff/mysql')
    }
    'lvm': {
      $content = template('backup/agent/rdiff/lvm')
    }
    default: {
      fail("Unknown type ${sourceType}")
    }
  }

  file {'/usr/local/bin/backup.sh':
    ensure => file,
    content => $content,
  }

  cron {"backup":
    command => 'bash /usr/local/bin/backup.sh',
    user    => 'root',
    minute  => $cronTimeMinute,
    hour    => $cronTimeHour,
  }

  file {'/usr/local/bin/check-backup.sh':
    ensure => file,
    content => template('backup/agent/rdiff/check')
  }

  cron {"backup-check":
    command => 'bash /usr/local/bin/check-backups.sh',
    user    => 'root',
    minute  => 10,
    hour    => 3,
  }
}