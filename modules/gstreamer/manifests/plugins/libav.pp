class gstreamer::plugins::libav (
  $version = 'present',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-libav':
    ensure => $version,
    provider => 'apt',
  }
}
