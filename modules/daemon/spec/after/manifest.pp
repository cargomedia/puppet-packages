node default {

  File {
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
  }

  file {
    '/tmp/my-program':
      ensure  => file,
      content => "#!/bin/bash\n while [ -e /tmp/created_before ]; do sleep 1; done";
    '/tmp/my-program-dependency':
      ensure  => file,
      content => "#!/bin/bash\n touch /tmp/created_before",
  }

  if ($::facts['service_provider'] == 'systemd') {
    systemd::unit { 'foo':
      content => template('daemon/spec/foo.service'),
      require => File['/tmp/my-program-dependency'],
    }
  } else {
    # Mocking file creation for Wheezy
    file {
      '/tmp/created_before':
        ensure  => file,
    }
  }

  daemon { 'my-program':
    binary  => '/tmp/my-program',
    after   => [ 'network.target', 'foo.service'],
    require => File['/tmp/my-program'],
  }
}
