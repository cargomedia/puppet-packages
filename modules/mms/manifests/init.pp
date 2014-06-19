class mms (
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
    class {'mms::agent::backup':
      api_key => $apikey_backup
    }
  }

  if $apikey_monitoring {
    class {'mms::agent::monitoring':
      api_key => $apikey_monitoring
    }
  }
}
