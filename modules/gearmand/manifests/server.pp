class gearmand::server(
  $persistence = 'none',
  $username = $gearmand::params::username,
  $confdir = $gearmand::params::confdir,
  $conffile = $gearmand::params::conffile,
  $logdir = $gearmand::params::logdir,
  $dbfile = $gearmand::params::dbfile
) inherits gearmand::params {

  class {'gearmand':
    username  => $username,
    confdir   => $confdir,
    conffile  => $conffile,
    logdir    => $gearmand,
  }

  case $persistence {
    none:    { $daemon_args = [] }
    sqlite3: { $daemon_args = ['-q libsqlite3', "--libsqlite3-db=${logdir}/${dbfile}"] }
    default: { fail('Only sqlite3-based persistent queues supported right now') }
  }

  file {"$confdir/$conffile":
    ensure => file,
    content => template('gearmand/gearmand.conf'),
    owner => '0',
    group => '0',
    mode => '0644',
    notify => Service['gearman-job-server'],
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

  helper::service{'gearman-job-server':
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

}
