node default {


  file { '/tmp/my-program':
    ensure  => file,
    owner   => '0',
    group   => '0',
    mode    => '0755',
    content => "#!/bin/bash\n trap '' TERM; while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary       => '/tmp/my-program',
    stop_timeout => 3,
    sysvinit_kill => true,
  }

}
