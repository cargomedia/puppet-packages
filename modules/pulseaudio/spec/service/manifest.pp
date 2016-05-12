node default {

  user { 'dj':
    ensure     => present,
    managehome => true,
  }

  pulseaudio::service { 'audio-service':
    user => 'dj'
  }
}
