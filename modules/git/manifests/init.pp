class git {

  require 'apt'

  package { 'git':
    provider => 'apt',
    ensure => present,
  }
}
