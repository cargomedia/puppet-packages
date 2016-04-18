class gstreamer::plugins::bad (
  $version = 'present',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-bad':
    ensure => $version,
    provider => 'apt',
  }
}
