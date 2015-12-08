class gstreamer::plugins::good(
  $version = '1.6.1'
) {

  require 'gstreamer'
  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-good': }
}
