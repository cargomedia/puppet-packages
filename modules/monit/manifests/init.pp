class monit ($emailTo = 'root@localhost', $emailFrom = undef, $allowedHosts = []) {

  require 'apt'
  require 'postfix::service'
  include 'monit::service'

  $domainWithDefault = $::trusted['domain'] ? {
    undef => 'localhost',
    default => $::trusted['domain'],
  }
  $emailFromWithDefault = $emailFrom ? {
    undef => "root@${domainWithDefault}",
    default => $emailFrom,
  }

  file { '/etc/default/monit':
    ensure  => file,
    content => template("${module_name}/default"),
    group   => '0',
    owner   => '0',
    mode    => '0644',
    notify  => Service['monit'],
  }
  ->

  file { '/etc/monit':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
  }
  ->

  file { '/etc/monit/conf.d':
    ensure => directory,
    group  => '0',
    owner  => '0',
    mode   => '0755',
    purge   => true,
    recurse => true,
  }
  ->

  file {
    '/etc/monit/templates':
      ensure => directory,
      group  => '0',
      owner  => '0',
      mode   => '0755';

    '/etc/monit/templates/alert-default':
      ensure  => file,
      content => template("${module_name}/templates/alert-default"),
      group   => '0',
      owner   => '0',
      mode    => '0755';

    '/etc/monit/templates/alert-none':
      ensure  => file,
      content => template("${module_name}/templates/alert-none"),
      group   => '0',
      owner   => '0',
      mode    => '0755';
  }
  ->

  file { '/usr/local/bin/monit-alert':
    ensure  => file,
    content => template("${module_name}/bin/monit-alert.sh"),
    group   => '0',
    owner   => '0',
    mode    => '0755',
  }
  ->

  exec { '/etc/monit/conf.d/alert':
    command => 'ln -s /etc/monit/templates/alert-default /etc/monit/conf.d/alert',
    user    => 'root',
    path    => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates => '/etc/monit/conf.d/alert',
  }
  ->

  file { '/etc/monit/monitrc':
    ensure  => file,
    content => template("${module_name}/monitrc"),
    group   => '0',
    owner   => '0',
    mode    => '0600',
    notify  => Service['monit'],
  }

  file { '/etc/init.d/monit':
    ensure  => file,
    content => template("${module_name}/init"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    notify  => Service['monit'],
  }
  ->

  package { 'monit':
    ensure   => present,
    provider => 'apt',
  }

  Monit::Entry <||>
}
