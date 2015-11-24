class ntp {

  require 'apt'

  package { 'ntp':
    ensure => present,
    provider => 'apt',
  }

  service { 'ntp':
    hasrestart => true,
    enable     => true,
    require    => Package['ntp'],
  }

  @monit::entry { 'ntp':
    content => template("${module_name}/monit"),
    require => Service['ntp'],
  }
}
