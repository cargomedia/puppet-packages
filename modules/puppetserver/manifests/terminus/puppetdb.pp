class puppetserver::terminus::puppetdb(
  $port,
) {

  require 'apt'
  include 'puppetserver'

  file { '/etc/puppetlabs/puppet/puppetdb.conf':
    ensure  => file,
    content => template("${module_name}/puppet/puppetdb.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['puppetserver'],
    notify  => Service['puppetserver'],
  }

  file { '/etc/puppetlabs/puppet/conf.d/puppetdb':
    ensure  => file,
    content => template("${module_name}/puppet/conf.d/puppetdb"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['/etc/puppetlabs/puppet/puppet.conf'],
    before  => Package['puppetserver'],
  }

  file { '/etc/puppetlabs/puppet/routes.yaml':
    ensure  => file,
    content => template("${module_name}/puppet/routes.yaml"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['puppetserver'],
    before  => Package['puppetserver'],
  }

  package { 'puppetdb-terminus':
    ensure   => present,
    provider => 'apt',
  }
}
