class passenger (
  $version = '4.0.38',
  $passenger_ruby = '/usr/bin/ruby',
  $gem_home = '/var/lib/gems/1.9.1'
){

  include 'build'
  include 'apache2::dev'
  include 'apache2'

  $gem_binary_path = "${gem_home}/bin"
  $passenger_root = "${gem_home}/gems/passenger-${version}"
  $mod_passenger_location = "${gem_home}/gems/passenger-${version}/buildout/apache2/mod_passenger.so"

  file {'/etc/apache2/mods-available/passenger.load':
    ensure  => present,
    content => template('passenger/passenger-load'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
  }

  file {'/etc/apache2/mods-available/passenger.conf':
    ensure  => present,
    content => template('passenger/passenger-enabled'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
  }

  file {'/etc/apache2/mods-enabled/passenger.load':
    ensure  => 'link',
    target  => '/etc/apache2/mods-available/passenger.load',
    owner   => '0',
    group   => '0',
    mode    => '0777',
    require => [ File['/etc/apache2/mods-available/passenger.load'], Exec['compile-passenger'] ],
    notify  => Service['apache2'],
  }

  file {'/etc/apache2/mods-enabled/passenger.conf':
    ensure  => 'link',
    target  => '/etc/apache2/mods-available/passenger.conf',
    owner   => '0',
    group   => '0',
    mode    => '0777',
    require => File['/etc/apache2/mods-available/passenger.conf'],
    notify  => Service['apache2'],
  }

  package {['libruby', 'libcurl4-openssl-dev']:
    ensure => present,
  }
  ->

  package {'passenger':
    ensure   => $version,
    provider => 'gem',
  }
  ->

  exec {'compile-passenger':
    path      => [ $gem_binary_path, '/usr/bin', '/bin', '/usr/local/bin' ],
    command   => 'passenger-install-apache2-module -a',
    logoutput => on_failure,
    creates   => $mod_passenger_location,
    require => [ Package['passenger'], Class['apache2::dev', 'build'] ],
  }

}
