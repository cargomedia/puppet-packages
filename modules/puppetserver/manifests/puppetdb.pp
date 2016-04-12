class puppetserver::puppetdb (
  $port,
  $port_ssl
) {

  require 'apt'
  require 'puppetserver'

  $path_ssl_private = '/etc/puppetdb/ssl/private.pem'
  $path_ssl_public = '/etc/puppetdb/ssl/public.pem'
  $path_ssl_ca = '/etc/puppetdb/ssl/ca.pem'

  Exec {
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

  file { '/etc/default/puppetdb':
    ensure  => file,
    content => template("${module_name}/puppetdb/default"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['puppetdb'],
  }
  ->

  package { 'puppetdb':
    ensure   => present,
    provider => 'apt',
  }
  ->

  file { '/etc/puppetdb/ssl':
    ensure => directory,
    owner  => 'puppetdb',
    group  => 'puppetdb',
    mode   => '0700',
  }
  ->

  exec { $path_ssl_private:
    command => "cp $(puppet master --configprint hostprivkey) ${path_ssl_private} && chown puppetdb:puppetdb ${path_ssl_private} && chmod 600 ${path_ssl_private}",
    creates => $path_ssl_private,
  }
  ->

  exec { $path_ssl_public:
    command => "cp $(puppet master --configprint hostcert) ${path_ssl_public} && chown puppetdb:puppetdb ${path_ssl_public} && chmod 600 ${path_ssl_public}",
    creates => $path_ssl_public,
  }
  ->

  exec { $path_ssl_ca:
    command => "cp $(puppet master --configprint localcacert) ${path_ssl_ca} && chown puppetdb:puppetdb ${path_ssl_ca} && chmod 600 ${path_ssl_ca}",
    creates => $path_ssl_ca,
  }
  ->

  file { '/etc/puppetdb/conf.d':
    ensure => directory,
    owner  => 'puppetdb',
    group  => 'puppetdb',
    mode   => '0640',
  }

  file { '/etc/puppetdb/conf.d/config.ini':
    ensure  => file,
    content => template("${module_name}/puppetdb/config.ini"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
  }

  file { '/etc/puppetdb/conf.d/jetty.ini':
    ensure  => file,
    content => template("${module_name}/puppetdb/jetty.ini"),
    owner   => 'puppetdb',
    group   => 'puppetdb',
    mode    => '0640',
    notify  => Service['puppetdb'],
  }

  service { 'puppetdb':
    enable => true,
  }

  @monit::entry { 'puppetdb':
    content => template("${module_name}/puppetdb/monit"),
    require => Service['puppetdb'],
  }
}
