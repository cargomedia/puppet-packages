class puppet::db {

  file {'/etc/default/puppetdb':
    ensure => file,
    content => template('puppet/default/db'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  package {'puppetdb':
    ensure => present,
  }
}
