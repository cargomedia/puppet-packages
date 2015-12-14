class gstreamer::plugins::ugly (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-ugly':
    ensure => $version,
    provider => 'apt',
  }
}
