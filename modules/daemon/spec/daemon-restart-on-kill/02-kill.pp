node default {

  exec { 'pkill -f "^/bin/bash /tmp/my-program -a bar -c foo$" && sleep 20':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin']
  }
}
