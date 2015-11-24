class rsync {

  require 'apt'

  package { 'rsync':
    ensure => present,
    provider => 'apt',
  }
}
