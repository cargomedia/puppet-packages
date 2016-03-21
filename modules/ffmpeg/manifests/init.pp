class ffmpeg {

  require 'apt::source::cargomedia'

  package { 'ffmpeg-cm':
    provider => 'apt',
  }
}
