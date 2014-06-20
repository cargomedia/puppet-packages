class mms (
  $api_key = undef
) {

  user {'mongodb-mms-agent':
    ensure => present,
    system => true,
  }

  file {'/var/run/mongodb-mms':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
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
