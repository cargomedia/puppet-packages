class python {

  require 'apt'

  package { ['python', 'python-pip']:
    ensure => present,
    provider => 'apt',
  }

}
