node default {

  if ($::facts['service_provider'] == 'debian') {
    exec { 'stop my-program':
      command => '/etc/init.d/my-program stop || echo "stop failed" >> /tmp/spec-log'
    }
  }
  if ($::facts['service_provider'] == 'systemd') {
    service { 'my-program':
      ensure   => 'stopped',
    }
  }

}
