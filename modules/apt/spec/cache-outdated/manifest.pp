node default {

  include 'apt::update'

  package { 'git':
    ensure => installed
  }
  ->

  exec { 'make cache outdated':
    command     => 'sudo touch -mt 0711171533 /var/cache/apt /var/cache/apt/*',
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }
  ->

  package { 'less':
    ensure => installed
  }
}
