class ntp {

  package {'ntp':
    ensure => present,
  }

  service {'ntp':
    hasrestart => true,
  }

  @monit::entry {'ntp':
    content => template('ntp/monit'),
    require => Service['ntp'],
  }
}
