class php5::fpm {

  require 'php5'
  require 'apt::source::dotdeb'

  package {'php5-fpm':
    ensure => present,
  }

  service {'php5-fpm':
    require => Package['php5-fpm'],
  }

  @monit::entry {'apache2':
    content => template('php5/fpm/monit'),
    require => Service['php5-fpm'],
  }
}
