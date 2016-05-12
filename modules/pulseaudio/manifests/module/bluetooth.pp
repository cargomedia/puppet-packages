class pulseaudio::module::bluetooth {

  package { 'pulseaudio-module-bluetooth':
    ensure   => installed,
    provider => apt,
  }
}
