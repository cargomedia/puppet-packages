class postgresql::client {

  require 'postgresql::common'

  package { 'postgresql-client-9.4':
    ensure   => present,
    provider => 'apt',
  }

}
