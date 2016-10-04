class ruby {

  require 'apt'

  package { ['ruby', 'ruby-dev']:
    ensure   => present,
    provider => 'apt',
  }
}
