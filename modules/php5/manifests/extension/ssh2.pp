class php5::extension::ssh2 {

  require 'apt'
  require 'php5'

  package { 'libssh2-php':
    provider => 'apt',
    ensure => present,
  }
}
