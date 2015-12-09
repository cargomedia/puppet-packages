class gstreamer::plugins::orc (
  $version = '0.4.24'
) {

  require 'apt::source::cargomedia'

  package { 'liborc-0.4-0':
    ensure => $version,
  }
}
