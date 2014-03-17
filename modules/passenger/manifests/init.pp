class passenger (
  $version = '4.0.38'
){

  include 'build'
  include 'apache2::dev'
  include 'apache2'

  $package_name           = 'passenger'
  $package_provider       = 'gem'
  $passenger_ruby         = '/usr/bin/ruby'
  $gem_binary_path        = '/var/lib/gems/1.9.1/bin'
  $passenger_root         = "/var/lib/gems/1.9.1/gems/passenger-${version}"
  $mod_passenger_location = "/var/lib/gems/1.9.1/gems/passenger-${version}/buildout/apache2/mod_passenger.so"

  if $::lsbdistcodename == 'squeeze' {
    $package_dependencies   = [ 'libopenssl-ruby', 'libcurl4-openssl-dev' ]
  } else {
    $package_dependencies   = [ 'libruby', 'libcurl4-openssl-dev' ]
  }

  file { '/etc/apache2/mods-available/passenger.load':
    ensure  => present,
    content => template('passenger/passenger-load'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-available/passenger.conf':
    ensure  => present,
    content => template('passenger/passenger-enabled'),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/passenger.load':
    ensure  => 'link',
    target  => '/etc/apache2/mods-available/passenger.load',
    owner   => '0',
    group   => '0',
    mode    => '0777',
    require => [ File['/etc/apache2/mods-available/passenger.load'], Exec['compile-passenger'] ],
    notify  => Service['apache2'],
  }

  file { '/etc/apache2/mods-enabled/passenger.conf':
    ensure  => 'link',
    target  => '/etc/apache2/mods-available/passenger.conf',
    owner   => '0',
    group   => '0',
    mode    => '0777',
    require => File['/etc/apache2/mods-available/passenger.conf'],
    notify  => Service['apache2'],
  }

  if $package_dependencies {
    package { $package_dependencies:
      ensure => present,
    }
  }

  package { 'passenger':
    ensure   => $version,
    name     => $package_name,
    provider => $package_provider,
    require => Package[$package_dependencies],
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
