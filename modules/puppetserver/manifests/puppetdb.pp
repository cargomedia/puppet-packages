class puppetserver::puppetdb (
  $port,
  $port_ssl,
  $vardir = '/var/lib/puppetdb',
  $heap_size = '100m',
) {

  require 'apt'
  require 'puppetserver'

  include 'puppetserver::puppetdb::certs'
  include 'puppetserver::puppetdb::postgresql'

  file { '/etc/default/puppetdb':
    ensure  => file,
    content => template("${module_name}/puppetdb/default"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['puppetdb'],
  }
  ->

  package { 'puppetdb':
    ensure   => present,
    provider => 'apt',
  }

  file { '/etc/puppetlabs/puppetdb/conf.d':
    ensure => directory,
    owner  => 'puppetdb',
    group  => 'puppetdb',
    mode   => '0640',
  }

  file { '/etc/puppetlabs/puppetdb/conf.d/config.ini':
    ensure  => file,
    content => template("${module_name}/puppetdb/config.ini"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
  }

  file { '/etc/puppetlabs/puppetdb/conf.d/jetty.ini':
    ensure  => file,
    content => template("${module_name}/puppetdb/jetty.ini"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
  }

  file { $vardir:
    ensure  => directory,
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
  }

  service { 'puppetdb':
    enable     => true,
    hasrestart => true,
  }
  ~>
  exec { 'start puppetdb':
    command     => 'service puppetdb start',
    refreshonly => true,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  @monit::entry { 'puppetdb':
    content => template("${module_name}/puppetdb/monit"),
    require => Service['puppetdb'],
  }

}
