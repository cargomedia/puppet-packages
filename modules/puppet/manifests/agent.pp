class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m'
) {

  include 'puppet::common'

  file {'/etc/puppet/conf.d/agent':
    ensure => file,
    content => template('puppet/agent/config'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['/etc/puppet/puppet.conf'],
  }
  ->

  file {'/etc/default/puppet':
    ensure => file,
    content => template('puppet/agent/default'),
    group => '0',
    owner => '0',
    mode => '0644',
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

  file {'/usr/local/bin/puppet-agent-check.rb':
    ensure => file,
    content => template('puppet/agent/puppet-agent-check.rb'),
    group => '0',
    owner => '0',
    mode => '0755',
  }

  @monit::entry {'puppet':
    content => template('puppet/agent/monit'),
    require => Service['puppet'],
  }

  @monit::entry {'puppet-agent-check':
    content => template('puppet/agent/monit-agent-check'),
    require => Service['puppet'],
  }
}
