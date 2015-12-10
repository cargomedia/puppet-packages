class gstreamer::plugins::orc (
  $version = '1:0.4.24-1',
) {

  require 'apt::source::cargomedia'

  package { 'liborc-0.4-0':
    ensure => $version,
  }
}
