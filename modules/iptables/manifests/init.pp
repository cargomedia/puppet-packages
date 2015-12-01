class iptables {

  require 'apt'

  package { 'iptables':
    ensure   => present,
    provider => 'apt',
  }
}
