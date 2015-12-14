class gstreamer::plugins::orc (
  $version = 'latest',
) {

  require 'apt::source::cargomedia'

  package { 'liborc-0.4-0':
    ensure => $version,
    provider => 'apt',
  }
}
