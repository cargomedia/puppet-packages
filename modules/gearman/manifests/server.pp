class gearman::server(
  $persistence = 'sqlite3',
  $jobretries = 25,
) {

  require 'apt::source::cargomedia'

  case $persistence {
    none:    { $daemon_args = [] }
    sqlite3: { $daemon_args = ['-q libsqlite3', "--libsqlite3-db=/var/log/gearman-job-server/gearman-persist.sqlite3"] }
    default: { fail('Only sqlite3-based persistent queues supported right now') }
  }

  package {'gearman-job-server':
    ensure => present,
    require => Class['apt::source::cargomedia'],
  }

  service {'gearman-job-server':
    hasrestart => true,
    require => Package['gearman-job-server'],
  }

  @monit::entry {'gearman-job-server':
    content => template('gearman/monit'),
    require => Service['gearman-job-server'],
  }

  @bipbip::entry {'gearman-job-server':
    plugin => 'gearman',
    options => {
      'hostname' => 'localhost',
      'port' => '4730',
    },
    require => Service['gearman-job-server'],
  }

  file {'/etc/default/gearman-job-server':
    ensure => file,
    content => template('gearman/default'),
    owner => '0',
    group => '0',
    mode => '0644',
    before => Package['gearman-job-server'],
    notify => Service['gearman-job-server'],
  }

}
