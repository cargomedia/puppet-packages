class mongodb (
  $version = '2.6'
){

  require 'apt'
  include 'ntp'

  case $version {

    '2.6': {
      $apt_repo = 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen'
      $apt_key = '7F0CEB10'
    }

    '3.0': {
      $apt_repo = 'deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/3.0 main'
      $apt_key = '7F0CEB10'
    }

    '3.2': {
      $apt_repo = 'deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main'
      $apt_key = 'EA312927'
    }

    '3.4': {
      $apt_repo = 'deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.4 main'
      $apt_key = 'EA312927'
    }

    default: {
      fail ("Unsupported mongodb version ${version}!")
    }
  }

  apt::source { 'mongodb':
    entries => [
      $apt_repo,
    ],
    keys    => {
      'mongodb' => {
        'key'        => $apt_key,
        'key_server' => 'hkp://keyserver.ubuntu.com:80',
      }
    },
  }

  user { 'mongodb':
    ensure => present,
    system => true,
  }

  file {
    '/var/lib/mongodb':
      ensure  => directory,
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb';

    '/etc/mongodb':
      ensure  => directory,
      mode    => '0755',
      owner   => 'mongodb',
      group   => 'mongodb';

    '/etc/init.d/mongod':
      ensure  => file,
      content => template("${module_name}/init-replacement"),
      mode    => '0755',
      owner   => 0,
      group   => 0;
  }
  ->

  package { 'mongodb-org':
    provider => 'apt',
    require  => [ Apt::Source['mongodb'] ]
  }
  ->

  service { 'mongod':
    ensure => stopped,
    enable => false,
  }
  ->

  file { '/etc/mongod.conf':
    ensure => absent,
  }

}
