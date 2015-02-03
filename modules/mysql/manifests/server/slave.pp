class mysql::server::slave ($replication_id, $server_id) {

  Mysql::Server::Instance <<| title == $replication_id |>>

  file { '/etc/mysql/conf.d/slave.cnf':
    ensure  => file,
    content => template("${module_name}/conf.d/slave.cnf"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  file { '/usr/local/bin/mysql-replication-check':
    ensure  => file,
    content => template("${module_name}/replication-check.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Service['mysql'],
  }
  ->

  cron { 'check-mysql':
    command => '/usr/local/bin/mysql-replication-check',
    user    => 'root',
  }
}
