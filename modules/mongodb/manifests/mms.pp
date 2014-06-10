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
      api_key => $apikey_backup
    }
  }

  if $apikey_monitoring {
    class {'mongodb::mms::monitoring':
      api_key => $apikey_monitoring
    }
  }
}
