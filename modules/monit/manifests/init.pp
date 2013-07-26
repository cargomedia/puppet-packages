class monit {

  package { 'monit':
    ensure => present,
  }
  ->

  file { '/etc/default/monit':
    content => 'startup=1',
    ensure => present,
    group => 0, owner => 0, mode => 644,
  }
}
