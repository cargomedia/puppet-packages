class backup::server (
  $type = $rdiff::params::type,
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

  monit::entry {'fs-check-home':
    content => template('backup/server/monit'),
  }

}