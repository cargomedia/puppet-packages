class puppet::agent ($server = 'puppet') {

  include 'puppet::common'

  file {'/etc/puppet/conf.d/agent':
    ensure => file,
    content => template('puppet/conf.d/agent'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['/etc/puppet/puppet.conf'],
  }
  ->

  file {'/etc/default/puppet':
    ensure => file,
    content => template('puppet/default'),
    group => '0',
    owner => '0',
    mode => '0644',
  }

  ->

  package {'puppet':
    ensure => '3.2.4-1puppetlabs1',
    require => [
      Package['puppet-common'],
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
