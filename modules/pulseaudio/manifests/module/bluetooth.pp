class pulseaudio::module::bluetooth {

  require 'pulseaudio'

  package { 'pulseaudio-module-bluetooth':
    provider => apt,
  }
}
