class accountsservice {

  require 'apt'

  package { ['accountsservice', 'policykit-1']:
    ensure   => present,
    provider => 'apt',
  }

}
