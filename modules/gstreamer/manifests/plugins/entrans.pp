class gstreamer::plugins::entrans (
  $version = 'present',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gst-entrans':
    ensure => $version,
    provider => 'apt',
  }
}
