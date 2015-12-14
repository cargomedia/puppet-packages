class gstreamer::plugins::base (
  $version = 'latest',
) {
  require 'apt::source::cargomedia'

  require 'gstreamer::plugins::orc'

  package { 'gstreamer1.0-plugins-base':
    ensure => $version,
    provider => 'apt',
  }
}
