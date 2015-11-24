class apache2::dev {

  require 'apt'

  package{ ['apache2-threaded-dev']:
    ensure   => present,
    provider => 'apt',
  }
}
