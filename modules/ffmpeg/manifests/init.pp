class ffmpeg {

  require 'apt::source::cargomedia'

  package { 'ffmpeg':
    provider => 'apt',
  }
}
