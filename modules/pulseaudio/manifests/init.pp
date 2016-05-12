class pulseaudio {

  package { 'pulseaudio':
    ensure   => installed,
    provider => apt,
  }
}
