class gstreamer::plugins::good (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-good':
    ensure => $version,
    provider => 'apt',
  }
}
