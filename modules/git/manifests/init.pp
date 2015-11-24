class git {

  require 'apt'

  package { 'git':
    ensure => present,
    provider => 'apt',
  }
}
