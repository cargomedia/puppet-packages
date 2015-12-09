class gstreamer(
  $version = '1.6.1'
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-tools': }
}
