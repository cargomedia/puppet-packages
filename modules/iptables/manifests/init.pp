class iptables {

  require 'apt'

  package { 'iptables':
    provider => 'apt',
    ensure => present,
  }
}
