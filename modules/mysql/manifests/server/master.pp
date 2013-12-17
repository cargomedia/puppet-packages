class mysql::server::master ($server_id) {

  class {'mysql::server':}

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
