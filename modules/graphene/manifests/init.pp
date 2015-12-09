class graphene (
  $version = '1.6.1'
) {

  require 'apt::source::cargomedia'

  package { 'graphene':
    ensure => $version,
  }
}
