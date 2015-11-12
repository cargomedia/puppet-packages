class nodejs {

  require 'apt::source::nodesource'

  package { 'nodejs':
    ensure => present,
  }

}
