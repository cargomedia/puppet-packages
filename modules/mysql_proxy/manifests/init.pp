class mysql_proxy ($host = '127.0.0.1', $port = 4040, $backend_addresses) {

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
    '/etc/mysql-proxy/failover.lua':
      ensure  => file,
      content => template("${module_name}/failover.lua.erb"),
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
    require => [ Package['mysql-proxy'], File['/etc/mysql-proxy/failover.lua', '/etc/mysql-proxy/config'] ],
  }
}
