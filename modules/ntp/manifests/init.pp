class ntp {

  package {'ntp':
    ensure => present,
  }

  service {'ntp':
    hasrestart => true,
    require => Package['ntp'],
  }

  @monit::entry {'ntp':
    content => template('ntp/monit'),
    require => Service['ntp'],
  }
}
