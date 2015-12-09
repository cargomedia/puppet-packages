class gstreamer::plugins::bad (
  $version = '1.6.1',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-bad':
    ensure => $version,
  }
}
