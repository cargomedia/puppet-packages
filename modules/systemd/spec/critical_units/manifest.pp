node default {

  systemd::service { 'foo':
    content  => template('systemd/spec/my-daemon.service'),
  }

  systemd::service { 'bar':
    content  => template('systemd/spec/my-daemon.service'),
  }
}
