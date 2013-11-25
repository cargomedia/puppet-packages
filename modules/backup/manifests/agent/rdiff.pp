class backup::agent::rdiff (
  $sourceType = $backup::params::sourceType,
  $host = $backup::params::host,
  $source = $backup::params::source,
  $destination = $backup::params::destination,
  $options = $backup::params::options,
  $cronTimeHour = $backup::params::cronTimeHour,
  $cronTimeMinute = $backup::params::cronTimeMinute
) inherits backup::params {

  include 'backup'
  include 'backup::base::rdiff'

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

  file {'/root/bin/backup.sh':
    ensure => file,
    content => $content,
  }

  cron {"backup":
    command => 'bash /root/bin/backup.sh',
    user    => 'root',
    minute  => $cronTimeMinute,
    hour    => $cronTimeHour,
  }

  file {'/root/bin/check-backup.sh':
    ensure => file,
    content => template('backup/agent/rdiff/check')
  }

  cron {"backup-check":
    command => 'bash /root/bin/check-backups.sh',
    user    => 'root',
    minute  => 10,
    hour    => 3,
  }
}