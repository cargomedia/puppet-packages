class ruby {

  require 'apt'

  package { ['ruby', 'ruby-dev', 'ri']:
    ensure   => present,
    provider => 'apt',
  }
}
