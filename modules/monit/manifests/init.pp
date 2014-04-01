class monit ($emailTo = 'root@localhost', $emailFrom = 'root@localhost', $allowedHosts = []) {

  include 'monit::service'

  file { '/etc/default/monit':
    ensure => file,
    content => template('monit/default'),
    group => '0',
    owner => '0',
    mode => '0644',
    notify => Service['monit'],
  }
  ->

  file { '/etc/monit':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0755',
  }
  ->

  file { '/etc/monit/conf.d':
    ensure => directory,
    group => '0',
    owner => '0',
    mode => '0755',
  }
  ->

  file {
    '/etc/monit/templates':
      ensure => directory,
      group => '0',
      owner => '0',
      mode => '0755';

    '/etc/monit/templates/alert-default':
      content => template('monit/templates/alert-default'),
      ensure => file,
      group => '0',
      owner => '0',
      mode => '0755';

    '/etc/monit/templates/alert-none':
      content => template('monit/templates/alert-none'),
      ensure => file,
      group => '0',
      owner => '0',
      mode => '0755';
  }
  ->

  file { '/usr/local/bin/monit-alert':
    ensure => file,
    content => template('monit/bin/monit-alert.sh'),
    group => '0',
    owner => '0',
    mode => '0755',
  }
  ->

  exec {'/etc/monit/conf.d/alert':
    command => 'ln -s /etc/monit/templates/alert-default /etc/monit/conf.d/alert',
    user => 'root',
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    creates => '/etc/monit/conf.d/alert',
  }
  ->

  file { '/etc/monit/monitrc':
    content => template('monit/monitrc'),
    ensure => file,
    group => '0',
    owner => '0',
    mode => '0600',
    notify => Service['monit'],
  }
  ->

  package {'monit':
    ensure => present,
  }

  Monit::Entry <||>
}
