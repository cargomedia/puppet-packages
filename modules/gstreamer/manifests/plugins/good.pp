class gstreamer::plugins::good (
  $version = '1.6.1'
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-good':
    ensure => $version,
  }
}
