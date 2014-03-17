class puppet::master::server_engine::webrick {

  service {'puppetmaster':
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }

  @monit::entry {'puppetmaster':
    content => template('puppet/master/monit'),
    require => Service['puppetmaster'],
  }

}
