class gstreamer::tools {

  require 'apt::source::cargomedia'

  package { 'gstreamer1.0-tools':
    provider => 'apt',
  }
}
