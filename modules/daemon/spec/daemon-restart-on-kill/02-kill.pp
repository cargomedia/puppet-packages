node default {

  exec { 'pkill -f "^/bin/bash /tmp/my-program$" && sleep 20':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
