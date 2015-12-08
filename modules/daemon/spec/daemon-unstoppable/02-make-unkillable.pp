node default {

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n trap '' TERM;\n while true; do sleep 1; done",
  }
  ~>

  service { 'my-program':
    provider => $::init_system,
  }

}
