class gentrans(
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gentrans':
    ensure => $version,
    provider => 'apt',
  }
}
