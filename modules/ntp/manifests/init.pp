class ntp {

  require 'apt'

  package { 'ntp':
    ensure   => present,
    provider => 'apt',
  }

  service { 'ntp':
    hasrestart => true,
    enable     => true,
    require    => Package['ntp'],
  }

  @systemd::critical_unit { 'ntp.service': }
}
