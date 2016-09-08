node default {

  systemd::service { 'my-daemon':
    content  => template('systemd/spec/my-daemon.service'),
  }
}
