class systemd {

  require 'apt'
  include 'systemd::coredump'
  include 'systemd::critical_units'

  package { 'systemd':
    ensure   => present,
    provider => 'apt',
  }


}
