class gearman::server (
  $persistence    = 'sqlite3',
  $mysql_host     = '127.0.0.1',
  $mysql_port     = '3306',
  $mysql_user     = 'gearman',
  $mysql_password = 'gearman',
  $mysql_db       = 'gearman',
  $mysql_table    = 'gearman_queue',
  $bind_ip        = undef,
  $jobretries     = 25,
) {

  require 'apt'
  require 'apt::source::cargomedia'

  $fullname = 'gearman-job-server'

  case $persistence {
    none: { $persistence_args = '' }
    sqlite3: { $persistence_args = "-q libsqlite3 --libsqlite3-db=/var/log/${fullname}/gearman-persist.sqlite3" }
    mysql: {
      $persistence_args = "-q mysql --mysql-host=${mysql_host} --mysql-port=${mysql_port} --mysql-user=${mysql_user} --mysql-password=${mysql_password} --mysql-db=${mysql_db} --mysql-table=${mysql_table}"
    }
    default: { fail('Only sqlite3 or mysql-based persistent queues supported right now') }
  }

  $listen_ip = $bind_ip ? {
    undef => '',
    default => "--listen=${bind_ip}",
  }
  $daemon_args = "${listen_ip} --job-retries=${jobretries} ${persistence_args} --log-file=/var/log/${fullname}/gearman.log"

  package { $fullname:
    ensure   => present,
    provider => 'apt',
    require  => [Class['apt::source::cargomedia'], Daemon[$fullname]],
  }

  @bipbip::entry { $fullname:
    plugin  => 'gearman',
    options => {
      'hostname'       => 'localhost',
      'port'           => '4730',
      'persistence'    => $persistence,
      'mysql_hostname' => $mysql_host,
      'mysql_port'     => $mysql_port,
      'mysql_username' => $mysql_user,
      'mysql_password' => $mysql_password,
      'mysql_database' => $mysql_db,
      'mysql_table'    => $mysql_table,

    },
    require => Daemon[$fullname],
  }

  user { 'gearman':
    ensure => present,
    system => true,
  }
  ->

  daemon { $fullname:
    binary       => '/usr/sbin/gearmand',
    args         => $daemon_args,
    user         => 'gearman',
    limit_nofile => 16384,
  }
}
