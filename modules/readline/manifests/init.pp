class readline {

  require 'apt'

  package { 'libreadline-dev':
    ensure   => present,
    provider => 'apt',
  }
}
