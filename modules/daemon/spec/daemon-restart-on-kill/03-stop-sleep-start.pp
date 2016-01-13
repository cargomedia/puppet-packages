node default {

  exec { 'systemctl stop my-program && sleep 20 && systemctl start my-program':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
