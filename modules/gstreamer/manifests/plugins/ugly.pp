class gstreamer::plugins::ugly (
  $version = '1.6.1-1ubuntu1',
) {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-ugly':
    ensure => $version,
    provider => 'apt',
  }
}
