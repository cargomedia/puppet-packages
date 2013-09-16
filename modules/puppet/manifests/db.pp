class puppet::db ($host) {

  file {'/etc/default/puppetdb':
    ensure => file,
    content => template('puppet/db/default'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  file {'/etc/puppetdb/conf.d/jetty.ini':
    ensure => file,
    content => template('puppet/db/conf.d/jetty.ini'),
    group => '0',
    owner => '0',
    mode => '0644',
  }
  ->

  package {'puppetdb':
    ensure => present,
  }
}
