node default {

  require 'php5::pear'

  package {'Auth':
    ensure => installed,
    provider => 'pear',
  }
}
