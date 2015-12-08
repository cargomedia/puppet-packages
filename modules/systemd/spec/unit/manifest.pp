node default {

  file { '/tmp/my-daemon':
    ensure  => file,
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }
  ->

  systemd::unit{ 'my-daemon':
    content  => template('systemd/spec/my-daemon.service'),
  }

  service { 'my-daemon':
  }

}
