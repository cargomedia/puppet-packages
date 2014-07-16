class puppet::agent (
  $server = 'puppet',
  $masterport = 8140,
  $runinterval = '10m',
  $cpu_shares = 1024,
  $splay = false,
  $splaylimit = undef,
) {

  include 'puppet::common'

  $splaylimit_final = $splaylimit ? {
    undef => $runinterval,
    default => $splaylimit,
  }

  if $cpu_shares < 1 or $cpu_shares > 1025 {
    fail "CPU shares must be in range 1 to 1024"
  }

  if $cpu_shares != 1024 {
    $cgroup_enabled = true
  }

  if $cgroup_enabled {
    cgroups::group {'puppet-agent-daemon':
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

  file {
    '/etc/puppet/conf.d/agent':
      ensure => file,
      content => template('puppet/agent/config'),
      group => '0',
      owner => '0',
      mode => '0644',
      notify => Exec['/etc/puppet/puppet.conf'];

    '/etc/default/puppet':
      ensure => file,
      content => template('puppet/agent/default'),
      group => '0',
      owner => '0',
      mode => '0644',
      notify => Service['puppet'];

    '/etc/init.d/puppet':
      ensure => file,
      content => template('puppet/agent/init'),
      group => '0',
      owner => '0',
      mode => '0755',
      notify => Service['puppet'];
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

  exec {'update-rc.d puppet defaults && /etc/init.d/puppet start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    subscribe => [ File['/etc/init.d/puppet'], File['/etc/default/puppet'] ],
    refreshonly => true,
  }

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
