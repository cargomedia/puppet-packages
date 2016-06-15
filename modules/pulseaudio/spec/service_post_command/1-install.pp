node default {

  require 'lightdm'

  user { 'dj':
    ensure     => present,
    managehome => true,
    groups     => ['audio'],
  }

  pulseaudio::service { 'audio-service':
    user         => 'dj',
    post_command => '/bin/systemctl restart lightdm'
  }
}
