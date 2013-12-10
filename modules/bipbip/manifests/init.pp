class bipbip (
  $api_key,
  $frequency = 5,
  $log = 'INFO'
){

  require 'ruby::gem::bipbip'
  include 'bipbip::service'

  user {'bipbip':
    ensure => present,
    system => true,
  }
  ->

  file {'/etc/bipbip':
    ensure => directory,
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0755',
  }
  ->

  file {'/etc/bipbip/services.d':
    ensure => directory,
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0755',
  }
  ->

  file {'/etc/bipbip/bipbip.yml':
    ensure => file,
    content => template('bipbip/bipbip.yml'),
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0755',
    notify => Service['bipbip'],
  }
  ->

  file {'/var/log/bipbip.log':
    ensure => file,
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0755',
  }
  ->

  file {'/etc/init.d/bipbip':
    ensure => file,
    content => template('bipbip/init.sh'),
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0755',
    notify => Service['bipbip'],
  }
  ~>

  exec {'update-rc.d bipbip defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

}