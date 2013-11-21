class backup::server (
  $type = $rdiff::params::type,
  $restoreList = $rdiff::params::restoreList,
  $checkEnable = $backup::params::checkEnable,
  $checkDestinations = $backup::params::checkDestinations
) inherits backup::params {

  include 'backup'

  if ($checkEnable == true and $checkDestinations == undef) {
    fail("Please specify destination for check job!")
  }

  case $type {
    'rdiff': {
      include 'backup::base::rdiff'

      if $restoreList != undef {
        create_resources('backup::server::rdiff-restore', $restoreList)
      }
    }
    default: {
      fail ("Unknown backup type ${type}!")
    }
  }

  if $checkEnable {
    file {'/root/bin/check-backup.sh':
      ensure => file,
      content => template('backup/server/backup-check')
    }

    cron {"backup-check":
      command => 'bash /root/bin/check-backups.sh',
      user    => 'root',
      minute  => 10,
      hour    => 3,
    }
  }

  monit::entry {'fs-check-home':
    content => template('backup/server/monit'),
  }

}