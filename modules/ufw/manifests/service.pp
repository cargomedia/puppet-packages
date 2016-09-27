class ufw::service {

  exec { 'Rebuild before.rules':
    command     => '/bin/cat /etc/ufw/before.d/* > /etc/ufw/before.rules',
    refreshonly => true,
    unless      => '/usr/bin/test ! -f /etc/ufw/before.d/*',
    subscribe   => File['/etc/ufw/before.d/'],
  }

  exec { 'Activate ufw':
    provider => shell,
    command  => 'echo "y" | ufw enable >/dev/null',
    unless   => 'ufw status | grep -q \'Status: active\'',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
    require  => Package['ufw'],
  }

  service { 'ufw':
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
    subscribe  => Exec['Rebuild before.rules'],
    require    => Exec['Activate ufw'],
  }
}
