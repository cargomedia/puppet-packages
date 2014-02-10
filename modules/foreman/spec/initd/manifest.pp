node default {

  class {'foreman::initd':
  }

  file {'/tmp/Procfile':
    ensure => file,
  }

}
