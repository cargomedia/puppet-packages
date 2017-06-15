class mysql_proxy (
  $host        = '127.0.0.1',
  $port        = 4040,
  $audit_users = [],
  $backend_addresses
) {

  require 'apt'
  require 'apt::source::cargomedia'

  file {
    '/etc/mysql-proxy':
      ensure => directory,
      owner  => '0',
      group  => '0',
      mode   => '0644';
    '/etc/mysql-proxy/config':
      ensure  => file,
      content => template("${module_name}/config"),
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => Package['mysql-proxy'],
      notify  => Service['mysql-proxy'];
    '/etc/mysql-proxy/script.lua':
      ensure  => file,
      content => template("${module_name}/script.lua"),
      owner   => '0',
      group   => '0',
      mode    => '0644',
      before  => Package['mysql-proxy'],
      notify  => Service['mysql-proxy'];
  }

  package { 'mysql-proxy':
    ensure   => present,
    provider => 'apt',
    require  => Class['apt::source::cargomedia'],
  }

  daemon { 'mysql-proxy':
    binary  => '/usr/bin/mysql-proxy',
    args    => '--defaults-file=/etc/mysql-proxy/config',
    env     => { 'LUA_PATH' => '/usr/share/mysql-proxy/?.lua' },
    require => [ Package['mysql-proxy'], File['/etc/mysql-proxy/script.lua', '/etc/mysql-proxy/config'] ],
  }
}
