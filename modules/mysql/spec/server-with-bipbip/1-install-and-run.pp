node default {

  class { 'mysql::server':
  }

  exec { 'chmod error log without restarting mysql-server':
    provider    => shell,
    command     => 'chmod 600 /var/log/mysql.err',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => Class['mysql::server'],
  }
}
