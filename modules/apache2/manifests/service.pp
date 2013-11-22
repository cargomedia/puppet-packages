class apache2::service {

  require 'apache2'

  service {'apache2':}

  @monit::entry {'apache2':
    content => template('apache2/monit'),
    require => Service['apache2'],
  }
}
