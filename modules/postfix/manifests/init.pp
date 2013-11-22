class postfix ($aliases = {}, $transports = []) {

  require 'ca-certificates'
  include 'postfix::service'

  file {'/etc/postfix':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0644',
  }

  file {'/etc/postfix/main.cf':
    ensure => file,
    content => template('postfix/main.cf'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['postfix'],
    before => Package['postfix'],
  }

  file {'/etc/postfix/header_checks':
    ensure => file,
    content => template('postfix/header_checks'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['postfix'],
    before => Package['postfix'],
  }

  file {'/etc/postfix/sasl_passwd':
    ensure => file,
    content => template('postfix/sasl_passwd'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['postmap'],
    before => Package['postfix'],
  }


  file {'/etc/postfix/virtual':
    ensure => file,
    content => template('postfix/virtual'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Exec['postmap'],
    before => Package['postfix'],
  }

  exec {'postmap':
    provider => shell,
    command => 'bash -c \'postmap /etc/postfix/{virtual,sasl_passwd}\'',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require => Package['postfix'],
    notify => Service['postfix'],
  }

  package {'libsasl2-modules':
    ensure => present,
  }

  package {'postfix':
    ensure => present,
    require => Package['libsasl2-modules'],
  }

  @monit::entry {'postfix':
    content => template('postfix/monit'),
    require => Package['postfix'],
  }
}
