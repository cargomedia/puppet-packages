node default {

  $daemon_name = 'my-program'

  user { 'alice':
    ensure => present,
  }

  file { "/tmp/${daemon_name}":
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n touch /tmp/my-program-start-stamp-$(date +%s.%N)\n while true; do sleep 1; done",
  }

  daemon { $daemon_name:
    binary           => "/tmp/${daemon_name}",
    user             => 'alice',
    require          => File["/tmp/${daemon_name}"],
  }
  ->

  exec { 'cleanup startup stamps':
    command => 'rm /tmp/my-program-start-stamp-*',
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }
  ->

  needrestart::service { $daemon_name:
    require => [Daemon[$daemon_name], Service[$daemon_name]]
  }
  ->

  exec { 'apt::upgrade':
    command => 'sudo apt-get upgrade -yy',
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }

}
