class puppet::db {

  file {'/etc/default/puppetdb':
    ensure => file,
    content => template('puppet/db/default'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['puppetdb'],
  }
  ->

  package {'puppetdb':
    ensure => present,
  }
  ->

  service {'puppetdb':}

  @monit::entry {'puppetdb':
    content => template('puppet/db/monit'),
    require => Service['puppetdb'],
  }
}
