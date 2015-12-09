class gstreamer::plugins::base (
  $version = '1.6.1',
  $with_orc = true,
) {
  require 'apt::source::cargomedia'

  if $with_orc {
    require 'gstreamer::plugins::orc'
  }

  package { 'gstreamer1.0-plugins-base':
    ensure => $version,
  }
}
