node default {

  user { 'alice':
    ensure => present,
  }

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary           => '/tmp/my-program',
    user             => 'alice',
    require          => File['/tmp/my-program'],
  }

  needrestart::service { 'my-service':
    require => [Daemon['my-program'], Service['my-program']]
  }
  ->

  exec { 'apt::upgrade':
    command => 'sudo apt-get upgrade -yy',
    path    => ['/bin','/usr/bin', '/usr/local/bin'],
  }

}
