class apache2 {

  require 'apt'
  include 'apache2::service'

  file { '/etc/apache2':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/apache2/httpd.conf':
    ensure => file,
    group  => '0',
    owner  => '0',
    mode   => '0644',
    notify => Service['apache2'],
  }

  file { '/etc/apache2/apache2.conf':
    ensure  => file,
    content => template("${module_name}/apache2.conf"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['apache2'],
  }
  ->

  package { 'apache2':
    ensure   => present,
    provider => 'apt',
  }
  ~>

  exec { 'Disable 000-default page and ports':
    command     => 'a2dissite 000-default',
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    notify => Service['apache2'],
  }
}
