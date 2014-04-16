class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m',
  $cpu_shares = 1024
) {

  include 'puppet::common'

  if $cpu_shares < 1 or $cpu_shares > 1025 {
    fail "CPU shares must be in range 1 to 1024"
  }

  if $cpu_shares != 1024 {
    $cgroup_enabled = true
  }

  if $cgroup_enabled {
    include 'cgroups'
    cgroups::group {'puppet':
      controllers => {
        'cpu' => {
          'cpu.shares' => $cpu_shares
        },
        'cpuset' => {
          'cpuset.cpus' => 0,
          'cpuset.mems' => 0,
        }
      }
    }
  }

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
  file {'/etc/init.d/puppet':
    ensure => file,
    content => template('puppet/agent/init'),
    group => '0',
    owner => '0',
    mode => '0755',
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
