class gstreamer::plugins::entrans {

  require 'apt::source::cargomedia'
  require 'gstreamer::plugins::base'

  package { 'gst-entrans':
    provider => 'apt',
  }
}
