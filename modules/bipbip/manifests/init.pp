class bipbip (
  $api_key,
  $version = '0.2.6',
  $frequency = 5,
  $log_file = '/var/log/bipbip.log',
  $log_level = 'INFO'
){

  include 'bipbip::service'

  class {'ruby::gem::bipbip':
    version => $version,
    notify => Service['bipbip'],
  }
  ->

  user {'bipbip':
    ensure => present,
    system => true,
  }
  ->

  file {'/etc/bipbip':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
  }
  ->

  file {'/etc/bipbip/services.d':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0644',
    purge => true,
    recurse => true,
  }
  ->

  file {'/etc/bipbip/config.yml':
    ensure => file,
    content => template('bipbip/config.yml'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['bipbip'],
  }
  ->

  file {'/var/log/bipbip.log':
    ensure => file,
    owner => 'bipbip',
    group => 'bipbip',
    mode => '0644',
  }
  ->

  file {'/etc/init.d/bipbip':
    ensure => file,
    content => template('bipbip/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['bipbip'],
  }
  ~>

  exec {'update-rc.d bipbip defaults && /etc/init.d/bipbip start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  Bipbip::Entry <||>

}
