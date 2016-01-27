node default {

  exec { 'pkill --signal SIGSEGV -f "^/bin/bash /tmp/my-daemon$"':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
