class gstreamer::plugins::entrans (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gst-entrans':
    ensure => $version,
    provider => 'apt',
  }
}
