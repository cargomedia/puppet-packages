node default {

  exec { 'log test':
    command     => 'logger [UFW Block] foo to bar',
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => [Class['ufw'],Service['rsyslog']],
  }
  ->

  exec { 'rotate ufw log':
    command     => 'logrotate -f /etc/logrotate.conf',
    provider    => shell,
    path        => ['/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    require     => [Class['ufw'],Service['rsyslog']],
  }
}
