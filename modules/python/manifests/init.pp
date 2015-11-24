class python {

  require 'apt'

  package { ['python', 'python-pip']:
    provider => 'apt',
    ensure => present,
  }

}
