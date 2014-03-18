class passenger (
  $version = '4.0.38',
  $passenger_ruby = '/usr/bin/ruby',
  $gem_home = '/var/lib/gems/1.9.1'
){

  require 'build'
  require 'apache2'
  require 'apache2::dev'

  $passenger_root = "${gem_home}/gems/passenger-${version}"
  $mod_passenger_location = "${gem_home}/gems/passenger-${version}/buildout/apache2/mod_passenger.so"

  apache2::mod {'passenger':
    configuration => template('passenger/passenger-enabled'),
    load_configuration => template('passenger/passenger-load'),
    notify  => Service['apache2'],
    require => Exec['compile-passenger']
  }

  package {['libcurl4-openssl-dev']:
    ensure => present,
  }
  ->

  ruby::gem {'passenger':
    ensure => $version,
  }
  ->

  exec {'compile-passenger':
    path      => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    command   => 'passenger-install-apache2-module -a',
    logoutput => on_failure,
    creates   => $mod_passenger_location,
  }

}
