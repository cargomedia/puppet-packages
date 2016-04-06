class puppetmaster (
  $dnsAltNames = [],
  $hiera_data_dir = '/etc/puppet/data',
  $hiera_environment = 'production',
  $reportToEmail = 'root',
  $puppetdb = false,
  $puppetdb_port = 8080,
  $puppetdb_port_ssl = 8081,
  $bootstrap_classes = [
    'puppet::agent',
  ],
  $puppetfile = undef,
  $port_webrick = 8140,
  $port_passenger = undef,
  $environmentpath = undef,
) {

  require 'apt'
  require 'ssh::auth::keyserver'
  include 'puppet::common'

  file { '/etc/puppet/conf.d/master':
    ensure  => file,
    content => template("${module_name}/master/conf.d/master"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['/etc/puppet/puppet.conf'],
    before  => Package['puppetmaster'],
  }

  file { '/etc/puppet/environments':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
  }

  file { '/etc/puppet/manifests':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
  }

  file { '/etc/puppet/manifests/site.pp':
    ensure  => file,
    content => template("${module_name}/master/site.pp"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetmaster'],
    notify  => Service['puppetmaster'],
  }

  file { $hiera_data_dir:
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
  }

  file { '/etc/puppet/hiera.yaml':
    ensure  => file,
    content => template("${module_name}/master/hiera.yaml"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetmaster'],
    notify  => Service['puppetmaster'],
  }

  file { '/etc/default/puppetmaster':
    ensure  => file,
    content => template("${module_name}/master/etc/default"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    before  => Package['puppetmaster'],
    notify  => Service['puppetmaster'],
  }

  if $reportToEmail {
    file { '/etc/puppet/tagmail.conf':
      ensure  => file,
      content => template("${module_name}/master/tagmail.conf"),
      group   => '0',
      owner   => '0',
      mode    => '0644',
      before  => Package['puppetmaster'],
      notify  => Service['puppetmaster'],
    }
  }

  package { 'puppetmaster':
    ensure   => present,
    provider => 'apt',
    require  => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppet/puppet.conf'],
      File['/etc/puppet/conf.d/main'],
    ],
  }
  ->

  service { 'puppetmaster':
    enable    => true,
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }

  if $puppetdb {
    class { 'puppetmaster::puppetdb':
      port     => $puppetdb_port,
      port_ssl => $puppetdb_port_ssl,
    }
    class { 'puppetmaster::terminus::puppetdb':
      port => $puppetdb_port_ssl,
    }
  }

  if $puppetfile {
    puppet::puppetfile { '/etc/puppet' :
      content => $puppetfile,
    }
  }

  if $port_passenger {
    class { 'puppetmaster::passenger':
      port    => $port_passenger,
      require => [Package['puppetmaster'], Service['puppetmaster']],
    }
  }

  @monit::entry { 'puppetmaster':
    content => template("${module_name}/master/monit"),
    require => Service['puppetmaster'],
  }

}
