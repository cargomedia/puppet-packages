class mysql::server::slave (
  $replication_id,
  $server_id
) {

  Mysql::Server::Instance <<| title == $replication_id |>>
  ->

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
  ->

  file { '/usr/local/bin/mysql-replication-check':
    ensure  => file,
    content => template("${module_name}/replication-check.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => [Service['mysql'], Bipbip::Entry['is-replication-running']],
  }

  mysql::user { 'bipbip@localhost':
    password => '',
    require => Bipbip::Entry['is-replication-running'],
  }

  @bipbip::entry { 'is-replication-running':
    plugin  => 'command',
    options => {
      'command'      => '/usr/local/bin/mysql-replication-check bipbip',
      'metric_group' => 'mysql',
    },
  }
}
