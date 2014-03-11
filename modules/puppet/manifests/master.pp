class puppet::master (
  $dnsAltNames = [],
  $hieraDataDir = '/etc/puppet/hiera/data',
  $reportToEmail = 'root',
  $puppetdb = false,
  $puppetdb_port = 8080,
  $puppetdb_port_ssl = 8081,
  $bootstrap_classes = [
    'puppet::agent',
    'monit' # See https://github.com/cargomedia/puppet-packages/issues/232
  ],
  $puppetfile = undef
) {

  require 'ssh::auth::keyserver'
  include 'puppet::common'

  file {'/etc/puppet/conf.d/master':
    ensure => file,
    content => template('puppet/master/conf.d/master'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['/etc/puppet/puppet.conf'],
    before => Package['puppetmaster'],
  }

  file {'/etc/puppet/manifests':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0755',
  }

  file {'/etc/puppet/manifests/site.pp':
    ensure => file,
    content => template('puppet/master/site.pp'),
    group => '0',
    owner => '0',
    mode => '0644',
    before => Package['puppetmaster'],
    notify => Service['puppetmaster'],
  }

  file {'/etc/puppet/hiera.yaml':
    ensure => file,
    content => template('puppet/master/hiera.yaml'),
    group => '0',
    owner => '0',
    mode => '0644',
    before => Package['puppetmaster'],
    notify => Service['puppetmaster'],
  }

  if $reportToEmail {
    file {'/etc/puppet/tagmail.conf':
      ensure => file,
      content => template('puppet/master/tagmail.conf'),
      group => '0',
      owner => '0',
      mode => '0644',
      before => Package['puppetmaster'],
      notify => Service['puppetmaster'],
    }
  }

  package {'puppetmaster':
    ensure => present,
    require => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppet/puppet.conf'],
      File['/etc/puppet/conf.d/main']
    ],
  }
  ->

  service {'puppetmaster':
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }

  if $puppetdb {
    class {'puppet::db':
      port => $puppetdb_port,
      port_ssl => $puppetdb_port_ssl,
    }
    class {'puppet::master::puppetdb':
      port => $puppetdb_port_ssl,
    }
  }

  if $puppetfile {
    class {'puppet::master::puppetfile':
      content => $puppetfile,
    }
  }

  @monit::entry {'puppetmaster':
    content => template('puppet/master/monit'),
    require => Service['puppetmaster'],
  }
}
