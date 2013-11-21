class backup::agent::rdiff (
  $host = $backup::params::host,
  $volume = $backup::params::volume,
  $source = $backup::params::source,
  $destination = $backup::params::destination,
  $options = $backup::params::options,
  $checkEnable = $backup::params::checkEnable,
  $checkDestinations = $backup::params::checkDestinations
) inherits backup::params {

  include 'backup'
  include 'backup::base::rdiff'

  if ($host == undef or $volume == undef or $source == undef or $destination == undef) {
    fail("Please specify all required params like host, volume, source and destination.")
  }

  if ($checkEnable == true and $checkDestinations == undef) {
    fail("Please specify destination for check job!")
  }

  file {'/root/bin/backup.sh':
    ensure => file,
    content => template('backup/agent/rdiff-script')
  }

  cron {"backup":
    command => 'bash /root/bin/backup.sh',
    user    => 'root',
    minute  => 0,
    hour    => 4,
  }

  if $checkEnable {
    file {'/root/bin/check-backup.sh':
      ensure => file,
      content => template('backup/agent/backup-check')
    }

    cron {"backup-check":
      command => 'bash /root/bin/check-backups.sh',
      user    => 'root',
      minute  => 10,
      hour    => 3,
    }
  }

}