class network::resolvconf (
) {

  require 'apt'

  package { 'resolvconf':
    ensure   => present,
    provider => 'apt',
  }

}
