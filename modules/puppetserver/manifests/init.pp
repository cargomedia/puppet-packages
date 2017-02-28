class puppetserver (
  $dnsAltNames       = [],
  $hiera_data_dir    = undef,
  $hiera_environment = 'production',
  $puppetdb          = false,
  $puppetdb_port     = 8080,
  $puppetdb_port_ssl = 8081,
  $bootstrap_classes = [
    'puppet::agent',
  ],
  $puppetfile        = undef,
  $port              = 8140,
  $heap_size         = '100m',
) {

  require 'apt'
  require 'ssh::auth::keyserver'
  include 'puppet::common'

  file { '/etc/puppetlabs/puppet/conf.d/master':
    ensure  => file,
    content => template("${module_name}/puppet/conf.d/master"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['/etc/puppetlabs/puppet/puppet.conf'],
    before  => Package['puppetserver'],
  }

  file { '/etc/puppetlabs/code/environments':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }

  puppetserver::environment { $hiera_environment:
    manifest       => template("${module_name}/puppet/site.pp"),
    puppetfile     => $puppetfile,
    hiera_data_dir => $hiera_data_dir,
  }

  file { ['/etc/puppetlabs/puppetserver', '/etc/puppetlabs/puppetserver/conf.d']:
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }

  file { '/etc/puppetlabs/puppetserver/conf.d/webserver.conf':
    ensure  => file,
    content => template("${module_name}/puppetserver/conf.d/webserver.conf.erb"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetserver'],
    notify  => Service['puppetserver'],
  }

  file { '/etc/default/puppetserver':
    ensure  => file,
    content => template("${module_name}/puppetserver/default"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetserver'],
    notify  => Service['puppetserver'],
  }

  package { 'puppetserver':
    ensure   => present,
    provider => 'apt',
    require  => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppetlabs/puppet/puppet.conf'],
    ],
  }
  ->

  service { 'puppetserver':
    enable     => true,
    hasrestart => true,
    subscribe  => Exec['/etc/puppetlabs/puppet/puppet.conf'],
  }
  ~>
  exec { 'start puppetserver':
    command     => 'service puppetserver start',
    refreshonly => true,
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  puppetserver::gem { $puppet::common::gems: }

  if $puppetdb {
    class { 'puppetserver::puppetdb':
      port     => $puppetdb_port,
      port_ssl => $puppetdb_port_ssl,
    }
    class { 'puppetserver::terminus::puppetdb':
      port => $puppetdb_port_ssl,
    }
  }

  @systemd::critical_unit { 'puppetserver.service': }

  @ufw::application { 'puppetserver':
    app_ports => "${port}/tcp",
  }
}
