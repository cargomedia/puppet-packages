class backup::agent::rdiff (
  $sourceType,
  $host,
  $source,
  $destination,
  $options = '--no-file-statistics --no-compare-inode',
  $cronTimeHour = 4,
  $cronTimeMinute = 0
) {

  require 'rdiff-backup'
  include 'backup'

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