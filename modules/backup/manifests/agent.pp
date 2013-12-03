define backup::agent (
  $server_id,
  $sourceType,
  $host,
  $source,
  $destination,
  $options = '--no-file-statistics --no-compare-inode',
  $cronTimeHour = 4,
  $cronTimeMinute = 0
) {

  require 'rdiff-backup'

  case $sourceType {
    'mysql': {
      $content = template('backup/agent/rdiff/mysql.sh')
    }
    'lvm': {
      $content = template('backup/agent/rdiff/lvm.sh')
    }
    default: {
      fail("Unknown type ${sourceType}")
    }
  }

  file {"/usr/local/bin/backup-${name}.sh":
    ensure => file,
    content => $content,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  cron {"backup-${name}":
    command => "/usr/local/bin/backup-${name}.sh",
    user    => 'root',
    minute  => $cronTimeMinute,
    hour    => $cronTimeHour,
  }

  file {"/usr/local/bin/backup-check-${name}.sh":
    ensure => file,
    content => template('backup/agent/rdiff/check.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
  }

  cron {"backup-check-${name}":
    command => "bash /usr/local/bin/backup-check-${name}.sh",
    user    => 'root',
    minute  => 10,
    hour    => 3,
  }
}
