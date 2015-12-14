class gstreamer::plugins::bad (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-bad':
    ensure => $version,
    provider => 'apt',
  }
}
