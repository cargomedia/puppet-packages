class ffmpeg {

  require 'apt::source::backports'

  package { 'ffmpeg':
    ensure   => present,
    provider => 'apt',
  }
}
