class mysql::server::slave ($server_id) {

  class {'mysql::server':}

  file {'/etc/mysql/conf.d/slave.cnf':
    ensure => file,
    content => template('mysql/conf.d/slave.cnf'),
    owner => 'root',
    group => 'mysql',
    mode => '0640',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }
}
