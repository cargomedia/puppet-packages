class systemd {

  require 'apt'

  package { 'systemd':
    ensure   => present,
    provider => 'apt',
  }

}
