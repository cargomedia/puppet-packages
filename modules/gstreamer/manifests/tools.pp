class gstreamer::tools(
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-tools':
    ensure => $version,
    provider => 'apt',
  }
}
