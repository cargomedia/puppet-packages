node default {

  user { 'dj':
    ensure     => present,
    managehome => true,
  }

  class { 'pulseaudio':
    user    => 'dj',
    require => User['dj'],
  }
}
