class gstreamer::plugins::base (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-base':
    ensure => $version,
    provider => 'apt',
  }
}
