class gearman::server(
  $persistence = 'sqlite3',
  $mysql_host = '127.0.0.1',
  $mysql_port = '3306',
  $mysql_user = 'gearman',
  $mysql_password = 'gearman',
  $mysql_db = 'gearman',
  $mysql_table = 'gearman_queue',
  $jobretries = 25,
) {

  require 'apt::source::cargomedia'

  case $persistence {
    none: { $daemon_args = [] }
    sqlite3: { $daemon_args = ['-q libsqlite3', '--libsqlite3-db=/var/log/gearman-job-server/gearman-persist.sqlite3'] }
    mysql: { $daemon_args = [
      "--queue-type=mysql",
      "--mysql-host=${mysql_host}",
      "--mysql-port=${mysql_port}",
      "--mysql-user=${mysql_user}",
      "--mysql-password=${mysql_password}",
      "--mysql-db=${mysql_db}",
      "--mysql-table=${mysql_table}"
    ] }
    default: { fail('Only sqlite3-based persistent queues supported right now') }
  }

  package { 'gearman-job-server':
    ensure  => present,
    require => Class['apt::source::cargomedia'],
  }

  service { 'gearman-job-server':
    hasrestart => true,
    enable     => true,
    require    => Package['gearman-job-server'],
  }

  @monit::entry { 'gearman-job-server':
    content => template("${module_name}/monit"),
    require => Service['gearman-job-server'],
  }

  @bipbip::entry { 'gearman-job-server':
    plugin  => 'gearman',
    options => {
      'hostname' => 'localhost',
      'port' => '4730',
    },
    require => Service['gearman-job-server'],
  }

  file { '/etc/default/gearman-job-server':
    ensure  => file,
    content => template("${module_name}/default"),
    owner   => '0',
    group   => '0',
    mode    => '0644',
    before  => Package['gearman-job-server'],
    notify  => Service['gearman-job-server'],
  }

}
