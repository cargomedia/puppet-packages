class gstreamer::plugins::gentrans (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gst-entrans':
    ensure => $version,
    provider => 'apt',
  }
}
