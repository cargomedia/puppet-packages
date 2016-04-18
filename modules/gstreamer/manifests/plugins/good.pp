class gstreamer::plugins::good {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-good':
    provider => 'apt',
  }
}
