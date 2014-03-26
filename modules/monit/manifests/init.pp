class monit (
  $version = '5.7',
  $emailTo = 'root@localhost',
  $emailFrom = 'root@localhost',
  $allowedHosts = []
) {

  include 'monit::service'

  file { '/etc/init.d/monit':
    ensure => file,
    content => template('monit/init'),
    group => '0',
    owner => '0',
    mode => '0755',
    notify => Service['monit'],
  }
  ->

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

  file { '/etc/monitrc':
    content => template('monit/monitrc'),
    ensure => file,
    group => '0',
    owner => '0',
    mode => '0600',
    notify => Service['monit'],
  }
  ->

  helper::script {'install monit':
    content => template('monit/install.sh'),
    unless => "test -x /usr/bin/monit && /usr/bin/monit -V | grep '^v${version}$'",
  }

  Monit::Entry <||>
}
