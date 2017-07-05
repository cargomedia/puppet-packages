class mysql::server::master (
  $replication_id,
  $server_id,
  $replication_password = undef,
  $root_password = undef,
  $debian_sys_maint_password = undef
) {

  @@mysql::server::instance { $replication_id:
    root_password             => $root_password,
    debian_sys_maint_password => $debian_sys_maint_password,
  }
  Mysql::Server::Instance <<| title == $replication_id |>>

  file { '/etc/mysql/conf.d/master.cnf':
    ensure  => file,
    content => template("${module_name}/conf.d/master.cnf"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  mysql::user { 'replication@%':
    password => $replication_password,
  }
  ->

  database_grant { 'replication@%':
    privileges => ['repl_slave_priv'],
    provider   => 'mysql',
  }

}
