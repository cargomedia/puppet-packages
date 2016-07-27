define custom_service {

  file { "/tmp/${name}":
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n touch /tmp/${name}-start-stamp-$(date +%s.%N)\n while true; do sleep 1; done",
  }

  daemon { $name:
    binary           => "/tmp/${name}",
    user             => 'alice',
    require          => File["/tmp/${name}"],
  }
  ->

  exec { "cleanup startup stamps for ${name}":
    command => "rm /tmp/${name}-start-stamp-*",
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }
  ->

  needrestart::service { $name:
    require => [Daemon[$name], Service[$name]]
  }
}

node default {

  user { 'alice':
    ensure => present,
  }

  custom_service { 'my-program1':
  }
  ->

  custom_service { 'my-program2':
  }
  ->

  custom_service { 'my-program3':
  }
  ->

  exec { 'apt::upgrade':
    command => 'sudo apt-get upgrade -yy',
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }

}
