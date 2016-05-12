class pulseaudio::module::bluetooth {

  require 'pulseaudio'

  package { 'pulseaudio-module-bluetooth':
    ensure   => installed,
    provider => apt,
  }
}
