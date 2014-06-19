class mms (
  $api_key = undef
) {

  user {'mongodb-mms-agent':
    ensure => present,
  }

  file {'/var/run/mongodb-mms':
    ensure => directory,
    require => User['mongodb-mms-agent']
  }

  if $api_key {
    class {'mms::agent::backup':
      api_key => $api_key
    }

    class {'mms::agent::monitoring':
      api_key => $api_key
    }
  }
}
