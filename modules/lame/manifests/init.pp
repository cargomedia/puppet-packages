class lame {

  require 'apt'

  package { 'lame':
    ensure   => present,
    provider => 'apt',
  }
}
