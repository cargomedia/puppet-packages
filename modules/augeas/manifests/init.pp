class augeas {

  require 'apt'

  package { 'libaugeas-ruby':
    ensure   => installed,
    provider => 'apt',
  }
}
