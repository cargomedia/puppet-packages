class augeas {

  require 'apt'

  package { 'libaugeas-ruby':
    provider => 'apt',
    ensure => installed,
  }
}
