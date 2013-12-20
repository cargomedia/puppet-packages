class gearmand::server {

  require 'gearmand'

  user {'gearmand':
    ensure => present,
  }

  file {'/etc/init.d/gearman-job-server':
    ensure => file,
    content => template('gearmand/init'),
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
    content => template('gearmand/monit'),
  }

  service {'gearman-job-server':
  }

}
