class systemd {

  require 'apt'
  include 'systemd::coredump'

  package { 'systemd':
    ensure   => present,
    provider => 'apt',
  }

}
