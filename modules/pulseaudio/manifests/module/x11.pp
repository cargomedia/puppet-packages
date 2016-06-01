class pulseaudio::module::x11 {

  require 'pulseaudio'

  package { 'pulseaudio-module-x11':
    provider => apt,
  }
}
