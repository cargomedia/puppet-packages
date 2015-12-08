node default {

  if ($::service_provider == 'debian') {
    exec { 'stop my-program':
      command => '/etc/init.d/my-program stop || echo "stop failed" >> /tmp/spec-log'
    }
  }
  if ($::service_provider == 'systemd') {
    service { 'my-program':
      provider => $::service_provider,
      ensure   => 'stopped',
    }
  }

}
