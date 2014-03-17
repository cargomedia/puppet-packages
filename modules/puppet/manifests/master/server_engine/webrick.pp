class puppet::master::server_engine::webrick {

  package {'puppetmaster':
    ensure => present,
    require => [
      Helper::Script['install puppet apt sources'],
      Exec['/etc/puppet/puppet.conf'],
      File['/etc/puppet/conf.d/main'],
    ],
  }

  service {'puppetmaster':
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }

  @monit::entry {'puppetmaster':
    content => template('puppet/master/monit'),
    require => Service['puppetmaster'],
  }

}
