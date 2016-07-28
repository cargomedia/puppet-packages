node default {

  $daemon_name = 'my-program1'

  exec { "echo '# make changes to trigger needrestart' >> /tmp/${daemon_name}":
    path => ['/bin','/usr/bin', '/usr/local/bin'],
  }
  ->

  exec { 'sudo apt-get upgrade -yy':
    path => ['/bin','/usr/bin', '/usr/local/bin'],
  }
}
