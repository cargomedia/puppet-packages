node default {

  if ($::service_provider == 'debian') {
    exec { 'noop':
      command => '/bin/true',
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
    }
  }

  if ($::service_provider == 'systemd') {
    exec { 'systemctl stop my-program && sleep 20 && systemctl start my-program':
      path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
    }
  }
}
