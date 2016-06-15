node default {

  exec { 'systemctl restart pulseaudio-dj':
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
  }
}
