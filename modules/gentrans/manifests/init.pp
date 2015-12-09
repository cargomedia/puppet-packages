class gentrans(
  $version = '1.6.1'
) {

  require 'apt::source::cargomedia'

  package { 'gentrans':
    ensure => $version,
  }
}
