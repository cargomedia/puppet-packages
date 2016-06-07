node default {

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file {
    '/usr/local/bin/my-program':
      ensure  => file,
      content => "#!/bin/bash\n while [ -e /tmp/TS_before ]; do echo $(date +%s.%N) >>/tmp/TS_running;sleep 1; done";
    '/usr/local/bin/my-program-before':
      ensure  => file,
      content => "#!/bin/bash\n echo $(date +%s.%N) > /tmp/TS_before";
    '/usr/local/bin/my-program-after':
      ensure  => file,
      content => "#!/bin/bash\n echo $(date +%s.%N) > /tmp/TS_after";
  }

  if ($::facts['service_provider'] == 'systemd') {
    systemd::unit {
      'foo-before':
        content => template('daemon/spec/foo-before.service'),
        require => File['/usr/local/bin/my-program-before'];
      'foo-after':
        content => template('daemon/spec/foo-after.service'),
        require => File['/usr/local/bin/my-program-after'],
    }
  } else {
    # Mocking file creation for Wheezy
    file {
      '/tmp/TS_before':
        ensure  => file;
      '/tmp/TS_after':
        ensure  => file;
    }
  }

  daemon { 'my-program':
    binary  => '/usr/local/bin/my-program',
    daemon_before  => [ 'foo-after.service' ],
    daemon_after   => [ 'network.target', 'foo-before.service'],
    require => [File['/usr/local/bin/my-program']],
  }
}
