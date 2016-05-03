node default {

  file { '/tmp/my-program-child':
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n trap '' TERM; while true; do sleep 1; done",
  }
  ~>

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'alice',
    group   => 'alice',
    mode    => '0755',
    content => "#!/bin/bash\n trap '' TERM; /tmp/my-program-child & /tmp/my-program-child",
  }
  ~>

  service { 'my-program':
  }

}
