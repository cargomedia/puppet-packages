class gstreamer::tools(
  $version = '1.6.1-1',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-tools':
    ensure => $version,
    provider => 'apt',
  }
}
