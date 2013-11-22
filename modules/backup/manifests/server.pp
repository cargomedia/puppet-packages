class backup::server (
  $type = $rdiff::params::type,
  $checkList = $backup::params::checkList,
  $restoreList = $rdiff::params::restoreList
) inherits backup::params {

  include 'backup'

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

  if $checkList != undef {
    file {'/root/bin/check-backup.sh':
      ensure => file,
      content => template('backup/server/rdiff/check')
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