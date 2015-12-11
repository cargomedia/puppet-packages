class puppetmaster::terminus::puppetdb(
  $port,
) {

  require 'apt'
  include 'puppetmaster'

  file { '/etc/puppet/puppetdb.conf':
    ensure  => file,
    content => template("${module_name}/master/puppetdb.conf"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['puppetmaster'],
    notify  => Service['puppetmaster'],
  }

  file { '/etc/puppet/conf.d/puppetdb':
    ensure  => file,
    content => template("${module_name}/master/conf.d/puppetdb"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['/etc/puppet/puppet.conf'],
    before  => Package['puppetmaster'],
  }

  file { '/etc/puppet/routes.yaml':
    ensure  => file,
    content => template("${module_name}/master/routes.yaml"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['puppetmaster'],
    before  => Package['puppetmaster'],
  }

  package { 'puppetdb-terminus':
    ensure   => present,
    provider => 'apt',
  }
}
