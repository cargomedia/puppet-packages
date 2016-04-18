class gstreamer::plugins::base {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-plugins-base':
    provider => 'apt',
  }
}
