class gstreamer::plugins::ugly (
  $version = 'present',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-ugly':
    ensure => $version,
    provider => 'apt',
  }
}
