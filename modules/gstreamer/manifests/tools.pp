class gstreamer::tools(
  $version = 'present',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-tools':
    ensure => $version,
    provider => 'apt',
  }
}
