node default {

  exec { 'systemctl stop lightdm':
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
  }
  ->

  exec { 'systemctl restart pulseaudio-dj':
    path => ['/bin', '/usr/bin', '/usr/local/bin'],
  }
}
