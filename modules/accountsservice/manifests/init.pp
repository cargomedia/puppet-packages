class accountsservice {

  require 'apt'

  package { ['accountsservice', 'policykit-1']:
    ensure   => present,
    provider => 'apt',
  }
  ~>

  exec { 'wait for dbus reload':
    command     => '/bin/sleep 10',
    refreshonly => true,
  }

}
