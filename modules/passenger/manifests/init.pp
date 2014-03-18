class passenger (
  $version = '4.0.38',
  $passenger_ruby = '/usr/bin/ruby',
  $gem_home = '/var/lib/gems/1.9.1'
){

  require 'ruby'
  require 'build'
  require 'apache2'
  require 'apache2::dev'

  $passenger_root = "${gem_home}/gems/passenger-${version}"
  $mod_passenger_location = "${gem_home}/gems/passenger-${version}/buildout/apache2/mod_passenger.so"

  file {'/etc/apache2/mods-available/passenger.load':
    ensure  => present,
    content => template('passenger/passenger-load'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
    require => Exec['compile-passenger'],
  }

  apache2::mod {'passenger':
    configuration => template('passenger/passenger-enabled'),
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
    require   => Package['passenger'],
  }

}
