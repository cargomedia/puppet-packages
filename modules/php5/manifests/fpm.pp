class php5::fpm {

  require 'php5'
  require 'apt::source::dotdeb' # Required in squeeze

  file {'/etc/php5/fpm':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  file {'/etc/php5/fpm/pool.d':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }

  file {'/etc/php5/fpm/php-fpm.conf':
    ensure => file,
    content => template('php5/fpm/php-fpm.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['php5-fpm'],
    notify => Service['php5-fpm'],
  }

  file {'/etc/php5/fpm/pool.d/www.conf':
    ensure => file,
    content => template('php5/fpm/www.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['php5-fpm'],
    notify => Service['php5-fpm'],
  }

  php5::config {'/etc/php5/fpm/php.ini':
    before => Package['php5-fpm'],
    notify => Service['php5-fpm'],
  }

  package {'php5-fpm':
    ensure => present,
  }

  service {'php5-fpm':
    require => Package['php5-fpm'],
  }

  @monit::entry {'php5-fpm':
    content => template('php5/fpm/monit'),
    require => Service['php5-fpm'],
  }

  @bipbip::entry {'php5-fpm':
    plugin => 'fastcgi-php-fpm',
    options => {
      'host' => 'localhost',
      'port' => 9000,
      'path' => '/fpm-status',
    }
  }

  @php5::fpm::with-apc {'php5-fpm-with-apc':
    host => 'localhost',
    port => 9000,
  }

}
