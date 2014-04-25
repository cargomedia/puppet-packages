class cgroups {

  include 'augeas'

  package {'cgroup-bin':
    ensure => present,
  }

  mount::entry {'mount cgroup':
    source => 'cgroup',
    target => '/sys/fs/cgroup',
    type => 'cgroup',
    options => 'defaults',
    mount => true,
    require => Package['cgroup-bin'],
  }

  file {'/etc/cgconfig.conf':
    ensure => file,
    mode => 0644,
    owner => 0,
    group => 0,
  }

  file {'augeas-lens':
    ensure => file,
    name => '/usr/share/augeas/lenses/dist/cgconfig.aug',
    source => 'puppet:///modules/cgroups/cgconfig.aug',
  }

  file {'/etc/init.d/cgconfig-apply':
    ensure => file,
    content => template('cgroups/init'),
    mode => 0755,
    owner => 0,
    group => 0,
    notify => Service['cgconfig-apply'],
  }
  ~>

  exec {'update-rc.d cgconfig-apply defaults && /etc/init.d/cgconfig-apply start':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  service {'cgconfig-apply':
    enable => true,
  }

}
