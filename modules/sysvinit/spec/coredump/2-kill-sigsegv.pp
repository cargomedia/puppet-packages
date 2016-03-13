node default {

  exec { 'pkill --signal SIGSEGV -f "^/bin/sh /tmp/bar"':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
