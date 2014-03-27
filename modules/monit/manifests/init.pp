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
