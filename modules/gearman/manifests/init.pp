class gearman ($server_version = '1.1.2', $server_series = '1.2') {

  include 'gearman::service'

  user {'gearman':
    ensure => present,
  }

  package {['libboost-all-dev', 'libevent-dev']:
    ensure => present,
  }
  ->

  helper::script {'install gearman':
    content => template('gearman/install'),
    unless => "test -x /usr/local/sbin/gearmand  && /usr/local/sbin/gearmand --version | grep -q '${server_version}')",
    require => User['gearman'],
  }

  file {'/etc/init.d/gearman-job-server':
    ensure => file,
    content => template('gearman/init'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['gearman-job-server'],
  }
  ~>

  exec {'update-rc.d gearman-job-server defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }

  @monit::entry {'gearman-job-server':
    content => template('gearman/monit'),
  }

}
