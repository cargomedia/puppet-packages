class mysql::server (
  $root_password             = '',
  $debian_sys_maint_password = '',
  $max_connections           = 500,
  $thread_cache_size         = 500,
  $key_buffer_size           = '512M',
) {

  require 'apt'
  require 'apt::source::mysql'

  # Do not use /var/log/mysql.err for the error log as it gets chmod'ded by mysql
  $error_log = '/var/log/my.err'
  $slow_query_log = '/var/log/mysql-slow-query.log'

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

  file { ['/etc/mysql', '/etc/mysql/conf.d', '/var/run/mysqld']:
    ensure  => directory,
    owner   => 'mysql',
    group   => 'mysql',
    mode    => '0755',
    require => User['mysql'],
  }

  file { '/etc/mysql/my.cnf':
    ensure  => file,
    content => template("${module_name}/my.cnf.erb"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/conf.d/init-file.cnf':
    ensure  => file,
    content => template("${module_name}/init-file.cnf"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/init.sql':
    ensure  => file,
    content => template("${module_name}/init.sql"),
    owner   => 'root',
    group   => 'mysql',
    mode    => '0640',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
    notify  => Service['mysql'],
  }

  file { '/etc/mysql/debian.cnf':
    ensure  => file,
    content => template("${module_name}/debian.cnf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0600',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
    notify  => Service['mysql'],
  }

  file { '/etc/tmpfiles.d/mysql.conf':
    ensure  => file,
    content => template("${module_name}/tmpfiles.d/mysql.conf"),
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
  }

  file { $error_log:
    ensure  => file,
    owner   => 'mysql',
    group   => 'mysql',
    mode    => '0644',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
  }

  file { $slow_query_log:
    ensure  => file,
    owner   => 'mysql',
    group   => 'root',
    mode    => '0644',
    before  => Service['mysql'],
    require => [User['mysql'], Package['mysql-server']],
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
    require  => Class['apt::source::mysql'],
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
    binary       => '/usr/sbin/mysqld',
    pre_command  => '/usr/share/mysql/mysql-systemd-start pre',
    post_command => '/usr/share/mysql/mysql-systemd-start post',
    user         => 'mysql',
    stop_timeout => 600,
    limit_nofile => 16384,
    kill_mode    => 'control-group',
    require      => [ User['mysql'], File['/usr/share/mysql/mysql-systemd-start'] ],
  }

  logrotate::entry { 'mysql-slow-query':
    path             => $slow_query_log,
    rotation_newfile => 'create 0644 mysql root',
    before           => Package['mysql-server'],
  }

  logrotate::entry { 'mysql-server-error':
    path             => $error_log,
    rotation_newfile => 'create 0644 mysql root',
    before           => Package['mysql-server'],
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
}
