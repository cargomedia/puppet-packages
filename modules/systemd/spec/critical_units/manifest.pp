node default {

  systemd::unit { 'my-daemon':
    content  => template('systemd/spec/my-daemon.service'),
  }
}
