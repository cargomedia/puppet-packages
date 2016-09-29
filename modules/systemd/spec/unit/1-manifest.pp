node default {

  class { 'sysctl::entry::core_pattern':
    pattern => '/tmp/foo.%e.%p.%h.%t'
  }

  file { '/tmp/my-daemon':
    ensure  => file,
    mode    => '0755',
    content => "#!/bin/bash\n while true; do sleep 1; done",
  }
  ->

  systemd::service{ 'my-daemon':
    content  => template('systemd/spec/my-daemon.service'),
  }

  class { 'systemd::coredump':
    compress => 'no',
    max_use  => 10000,
  }

  service { 'my-daemon':
  }

}
