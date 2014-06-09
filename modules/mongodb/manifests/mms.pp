class mongodb::mms (
  $apikey_backup = undef,
  $apikey_monitoring = undef
) {

  user {'mongodb-mms-agent':
    ensure => present,
  }

  file {'/var/run/mongodb-mms':
    ensure => directory,
    require => User['mongodb-mms-agent']
  }

  if $apikey_backup {
    class {'mongodb::mms::backup':
      apikey => $apikey_backup
    }
  }

  if $apikey_monitoring {
    class {'mongodb::mms::monitoring':
      apikey => $apikey_monitoring
    }
  }
}
