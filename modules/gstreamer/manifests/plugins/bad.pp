class gstreamer::plugins::bad {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gstreamer1.0-plugins-bad':
    provider => 'apt',
  }
}
