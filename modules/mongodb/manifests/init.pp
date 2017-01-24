class mongodb {

  require 'apt'
  include 'ntp'

  apt::source { 'mongodb':
    entries => [
      'deb http://repo.mongodb.org/apt/debian jessie/mongodb-org/3.2 main',
    ],
    keys    => {
      'mongodb' => {
        'key' => 'EA312927',
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

    '/var/log/mongodb':
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
