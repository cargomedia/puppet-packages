class gstreamer::plugins::good (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-good':
    ensure => $version,
    provider => 'apt',
  }
}
