class postfix (
  $aliases = { },
  $relay = undef,
  $relay_filters = [],
) {
  require 'apt'
  require 'ca_certificates'
  include 'postfix::service'

  $myhostname = $::facts['domain'] ? {
    undef => 'localhost',
    default => $::facts['domain'],
  }

  file { '/etc/postfix':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0644',
  }

  file { '/etc/postfix/main.cf':
    ensure  => file,
    content => template("${module_name}/main.cf"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['postfix'],
    before  => Package['postfix'],
  }

  file { '/etc/postfix/header_checks':
    ensure  => file,
    content => template("${module_name}/header_checks"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['postfix'],
    before  => Package['postfix'],
  }

  file { '/etc/postfix/sasl_passwd':
    ensure  => file,
    content => template("${module_name}/sasl_passwd"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['postmap'],
    before  => Package['postfix'],
  }

  file { '/etc/postfix/virtual':
    ensure  => file,
    content => template("${module_name}/virtual"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Exec['postmap'],
    before  => Package['postfix'],
  }

  exec { 'postmap':
    provider    => shell,
    command     => 'bash -c \'postmap /etc/postfix/{virtual,sasl_passwd}\'',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
    require     => Package['postfix'],
    notify      => Service['postfix'],
  }

  package { ['postfix', 'libsasl2-modules', 'bsd-mailx', 'procmail']:
    ensure   => present,
    provider => 'apt',
  }

  @systemd::critical_unit { 'postfix.service': }

  @bipbip::entry { 'postfix':
    plugin  => 'postfix',
    options => { },
  }
}
