class bipbip (
  $api_key,
  $version = 'latest',
  $frequency = 5,
  $tags = $::copperegg_tags,
  $log_file = '/var/log/bipbip/bipbip.log',
  $log_level = 'INFO',
){

  require 'logrotate'
  include 'bipbip::service'

  class { 'ruby::gem::bipbip':
    version => $version,
    notify  => Service['bipbip'],
  }
  ->

  user { 'bipbip':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/home/bipbip',
  }
  ->

  file { '/etc/bipbip':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }
  ->

  file { '/etc/bipbip/services.d':
    ensure  => directory,
    owner   => '0',
    group   => '0',
    mode    => '0644',
    purge   => true,
    recurse => true,
  }
  ->

  file { '/etc/bipbip/config.yml':
    ensure  => file,
    content => template("${module_name}/config.yml"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    notify  => Service['bipbip'],
  }
  ->

  file { '/var/log/bipbip':
    ensure => directory,
    owner  => 'bipbip',
    group  => 'bipbip',
    mode   => '0755',
  }
  ->

  file { '/var/log/bipbip/bipbip.log':
    ensure => file,
    owner  => 'bipbip',
    group  => 'bipbip',
    mode   => '0644',
  }
  ->

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  sysvinit::script { 'bipbip':
    content           => template("${module_name}/init.sh"),
    require           => [User['bipbip'], File['/etc/bipbip/config.yml']]
  }
  ->

  Bipbip::Entry <||>
}
