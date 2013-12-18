class mysql::server ($root_password = undef, $debian_sys_maint_password = undef) {

  include 'mysql::service'

  file {'/root/.my.cnf':
    ensure => $root_password ? {
      undef => absent,
      default => file,
    },
    content => template('mysql/client-config.cnf'),
    owner => '0',
    group => '0',
    mode => '0600',
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

  file {'/etc/mysql/conf.d':
    ensure => directory,
    owner => 'root',
    group => 'mysql',
    mode => '0750',
    require => User['mysql'],
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

  if ($debian_sys_maint_password) {
    file {'/etc/mysql/debian.cnf':
      ensure => file,
      content => template('mysql/debian.cnf'),
      owner => 'root',
      group => 'mysql',
      mode => '0640',
      require => User['mysql'],
      before => Package['mysql-server'],
      notify => Service['mysql'],
    }

    mysql::user {'debian-sys-maint@localhost':
      password => $debian_sys_maint_password,
    }
  }

  package {'mysql-server':
    ensure => present,
    before => Service['mysql'],
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
