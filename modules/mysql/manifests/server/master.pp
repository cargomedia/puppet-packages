class mysql::server::master ($cluster_name, $server_id, $root_password = undef, $debian_sys_maint_password = undef) {

  @@mysql::server::instance {$cluster_name:
    root_password => $root_password,
    debian_sys_maint_password => $debian_sys_maint_password,
  }
  Mysql::Server::Instance <<| title == $cluster_name |>>

  file {'/etc/mysql/conf.d/master.cnf':
    ensure => file,
    content => template('mysql/conf.d/master.cnf'),
    owner => 'root',
    group => 'mysql',
    mode => '0640',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }
}
