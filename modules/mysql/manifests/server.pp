class mysql::server ($root_password = '', $debian_sys_maint_password = '') {

  include 'mysql::service'

  file {'/root/.my.cnf':
    ensure => file,
    content => template('mysql/client-config.cnf'),
    owner => '0',
    group => '0',
    mode => '0600',
    before => Package['mysql-server'],
  }

  user {'mysql':
    ensure => present,
    system => true,
    home => '/var/lib/mysql',
    shell => '/bin/false',
  }

  file {'/etc/mysql':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/mysql/conf.d':
    ensure => directory,
    owner => 'root',
    group => 'mysql',
    mode => '0750',
    require => User['mysql'],
  }

  file {'/etc/mysql/my.cnf':
    ensure => file,
    content => template('mysql/my.cnf'),
    owner => 'root',
    group => 'mysql',
    mode => '0640',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }

  file {'/etc/mysql/conf.d/init-file.cnf':
    ensure => file,
    content => template('mysql/init-file.cnf'),
    owner => 'root',
    group => 'mysql',
    mode => '0640',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }

  file {'/etc/mysql/init.sql':
    ensure => file,
    content => template('mysql/init.sql'),
    owner => 'root',
    group => 'mysql',
    mode => '0640',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }

  file {'/etc/mysql/debian.cnf':
    ensure => file,
    content => template('mysql/debian.cnf'),
    owner => 'root',
    group => 'root',
    mode => '0600',
    require => User['mysql'],
    before => Package['mysql-server'],
    notify => Service['mysql'],
  }

  mysql::user {'debian-sys-maint@localhost':
    password => $debian_sys_maint_password,
  }

  mysql::user {'root@localhost':
    password => $root_password,
  }

  package {'mysql-server':
    ensure => present,
    before => Service['mysql'],
  }

  sysctl::entry {'mysql':
    entries => {
      'net.core.somaxconn' => 1536,
      'net.ipv4.tcp_max_syn_backlog' => 8192,
      'net.core.netdev_max_backlog' => 2048,
    }
  }

  ulimit::entry {'mysql':
    limits => [
      {
      'domain' => 'mysql',
      'type' => '-',
      'item' => 'nofile',
      'value' => 16384,
      }
    ]
  }

  @monit::entry {'mysql':
    content => template('mysql/monit'),
    require => Service['mysql'],
  }

  @bipbip::entry {'mysql':
    plugin => 'mysql',
    options => {
    'hostname' => 'localhost',
    'port' => '3306',
    'username' => 'debian-sys-maint',
    'password' => $debian_sys_maint_password,
    }
  }
}
