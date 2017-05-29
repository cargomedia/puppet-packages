node default {

  exec { 'add entry to observed file':
    provider => shell,
    command  => "echo '{\"message\":\"FOO\"}' >>/tmp/my-source-2",
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
  }

}
