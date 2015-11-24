class ruby {

  require 'apt'

  package { ['ruby', 'ruby-dev', 'ri']:
    provider => 'apt',
    ensure => present,
  }
}
