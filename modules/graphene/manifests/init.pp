class graphene (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'graphene':
    ensure => $version,
    provider => 'apt',
  }
}
