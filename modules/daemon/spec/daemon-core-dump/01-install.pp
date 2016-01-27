node default {

  require 'monit'

  user { 'myuser':
    ensure => present,
  }

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'myuser',
    group   => 'myuser',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary    => '/tmp/my-program',
    user      => 'myuser',
    core_dump => true,
  }
}
