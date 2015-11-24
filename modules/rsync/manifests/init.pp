class rsync {

  require 'apt'

  package { 'rsync':
    provider => 'apt',
    ensure => present,
  }
}
