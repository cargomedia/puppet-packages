class systemd {

  require 'apt'
  include 'systemd::coredump'

  package { 'systemd':
    ensure   => present,
    provider => 'apt',
  }

  class { 'systemd::critical_units':}

}
