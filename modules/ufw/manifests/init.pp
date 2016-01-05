class ufw {

  require 'apt'
  include 'ufw::service'

  package { 'ufw':
    ensure   => present,
    provider => 'apt',
  }
}
