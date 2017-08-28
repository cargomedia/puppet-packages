node default {

  systemd::service { 'stopped':
    content  => template('systemd/spec/stopped.service'),
  }

  systemd::service { 'failed':
    content  => template('systemd/spec/failed.service'),
  }
}
