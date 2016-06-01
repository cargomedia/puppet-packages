class openssl {

  require 'apt'

  package { ['openssl', 'libssl-dev']:
    ensure   => present,
    provider => 'apt',
  }

}
