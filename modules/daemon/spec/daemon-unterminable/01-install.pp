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
    binary       => '/tmp/my-program',
    user         => 'alice',
    stop_timeout => 3,
  }

  daemon { 'my-program-killable':
    binary       => '/tmp/my-program',
    user         => 'alice',
    forced_exit  => true,
    stop_timeout => 3,
  }
}
