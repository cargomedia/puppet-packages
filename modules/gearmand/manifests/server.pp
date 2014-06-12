class gearmand::server(
  $persistence = 'none'
) {

  require 'gearmand'

  user {'gearman':
    ensure => present,
  }

  case $persistence {
    none:    { $daemon_args = '' }
    sqlite3: { $daemon_args = "-q libsqlite3 --libsqlite3-db=${LOGDIR}/gearman-persist.sqlite3" }
    default: { fail('Only sqlite3-based persistent queues supported right now') }
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

  @bipbip::entry {'gearman':
    plugin => 'gearman',
    options => {
      'hostname' => 'localhost',
      'port' => '4730',
    }
  }

  service {'gearman-job-server':
  }

}
