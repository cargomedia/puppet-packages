class gstreamer::plugins::libav (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-libav':
    ensure => $version,
    provider => 'apt',
  }
}
