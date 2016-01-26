node default {

  exec { 'pkill --signal SIGSEGV -f "^/bin/bash /tmp/my-program$" && sleep 15':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
