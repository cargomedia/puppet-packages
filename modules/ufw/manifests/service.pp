class ufw::service {

  exec { 'Activate ufw':
    provider => shell,
    command  => 'echo "y" | ufw enable >/dev/null',
    unless   => 'ufw status | grep -q \'Status: active\'',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    user     => 'root',
    require  => Package['ufw'],
  }
  ->

  service { 'ufw':
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }
}
