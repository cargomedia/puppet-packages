node default {

  file { '/tmp/my-program':
    ensure  => file,
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }

  daemon { 'my-program':
    binary          => '/tmp/my-program',
    args            => '--foo=12',
    require         => File['/tmp/my-program'],
    start_on_create => false,
  }

}
