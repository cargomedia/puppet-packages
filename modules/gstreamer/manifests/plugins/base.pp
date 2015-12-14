class gstreamer::plugins::base (
  $version = '1.6.1-1ubuntu1',
) {
  require 'apt::source::cargomedia'

  require 'gstreamer::plugins::orc'

  package { 'gstreamer1.0-plugins-base':
    ensure => $version,
    provider => 'apt',
  }
}
