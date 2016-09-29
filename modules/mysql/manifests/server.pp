class mysql::server (
  $root_password = '',
  $debian_sys_maint_password = '',
  $max_connections = 500,
  $thread_cache_size = 500,
  $key_buffer_size = '512M',
) {

  require 'apt'

  $error_log = '/var/log/mysql.err'

  file { '/root/.my.cnf':
    ensure  => file,
    content => template("${module_name}/client-config.cnf"),
    owner   => '0',
    group   => '0',
    mode    => '0600',
    before  => Package['mysql-server'],
  }

  user { 'mysql':
    ensure => present,
    system => true,
    home   => '/var/lib/mysql',
    shell  => '/bin/false',
    before => Package['mysql-server'],
  }

  file { '/etc/mysql':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/mysql/conf.d':
    ensure  => directory,
    owner   => 'root',
    group   => 'mysql',
    mode    => '0750',
    require => User['mysql'],
  }

  file { '/etc/mysql/my.cnf':
    ensure  => file,
    content => template("${module_name}/my.cnf.erb"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/conf.d/init-file.cnf':
    ensure  => file,
    content => template("${module_name}/init-file.cnf"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/init.sql':
    ensure  => file,
    content => template("${module_name}/init.sql"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/debian.cnf':
    ensure  => file,
    content => template("${module_name}/debian.cnf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    require => User['mysql'],
    before  => Package['mysql-server'],
    notify  => Service['mysql'],
  }

  file { $error_log:
    ensure  => file,
    owner   => 'mysql',
    mode    => '0644',
    before  => Package['mysql-server'],
    require => User['mysql'],
  }

  mysql::user { 'debian-sys-maint@localhost':
    password => $debian_sys_maint_password,
  }

  mysql::user { 'root@localhost':
    password => $root_password,
  }

  package { 'mysql-server':
    ensure   => present,
    provider => 'apt',
    before   => Service['mysql'],
  }

  sysctl::entry { 'mysql':
    entries => {
      'net.core.somaxconn'           => 1536,
      'net.ipv4.tcp_max_syn_backlog' => 8192,
      'net.core.netdev_max_backlog'  => 2048,
    }
  }

  file { '/usr/share/mysql/mysql-systemd-start':
    ensure  => file,
    content => template("${module_name}/mysql-systemd-start.sh.erb"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    require => Package['mysql-server'],
  }

  daemon { 'mysql':
    binary                 => '/usr/sbin/mysqld',
    pre_command            => '/usr/share/mysql/mysql-systemd-start pre',
    post_command           => '/usr/share/mysql/mysql-systemd-start post',
    user                   => 'mysql',
    stop_timeout           => 600,
    limit_nofile           => 16384,
    runtime_directory      => 'mysqld',
    runtime_directory_mode => '0755',
    require                => [ User['mysql'], File['/usr/share/mysql/mysql-systemd-start'] ],
  }

  logrotate::entry { 'mysql-server-error':
    path               => $error_log,
    rotation_newfile   => 'create 0644 mysql root',
    before             => Package['mysql-server'],
  }

  @bipbip::entry { 'mysql':
    plugin  => 'mysql',
    options => {
      'hostname' => 'localhost',
      'port'     => '3306',
      'username' => 'debian-sys-maint',
      'password' => $debian_sys_maint_password,
    }
  }

  @bipbip::entry { 'logparser-mysql-errors':
    plugin  => 'log-parser',
    options => {
      'metric_group' => 'mysql',
      'path'         => $error_log,
      'matchers'     => [
        { 'name'   => 'crashed_tables',
          'regexp' => 'is marked as crashed' },
      ]
    },
  }
}
