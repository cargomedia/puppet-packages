class puppet::agent ($server = 'puppet') {

  include 'puppet::common'

  file {'/etc/puppet/conf.d/agent':
    content => template('puppet/conf.d/agent'),
    ensure => file,
    group => '0', owner => '0', mode => '0644',
    notify => Exec['/etc/puppet/puppet.conf'],
  }
  ->

  file {'/etc/default/puppet':
    content => template('puppet/default'),
    ensure => file,
    group => '0', owner => '0', mode => '0644',
  }
  ->

  package {'puppet':
    ensure => present,
    require => [
    Helper::Script['install puppet apt sources'],
    Exec['/etc/puppet/puppet.conf'],
    File['/etc/puppet/conf.d/main']
    ]
  }
  ->

  service {'puppet':
    subscribe => Exec['/etc/puppet/puppet.conf'],
  }
  ->

  monit::entry {'puppet':
    content => template('puppet/monit/agent')
  }
}
