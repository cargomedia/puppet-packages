node default {

  # stopped service
  systemd::service { 'foo':
    content  => template('systemd/spec/foo.service'),
  }

  # failing service
  systemd::service { 'bar':
    content  => template('systemd/spec/bar.service'),
  }
}
