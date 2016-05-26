node default {

  require 'bluetooth::bluez'

  user { 'dj':
    ensure     => present,
    managehome => true,
    groups     => ['audio'],
  }

  pulseaudio::service { 'audio-service':
    user => 'dj'
  }
}
