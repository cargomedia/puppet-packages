node default {

  if ($::init_system == 'sysvinit') {
    exec { 'stop my-program':
      command => '/etc/init.d/my-program stop || echo "stop failed" >> /tmp/spec-log'
    }
  }
  if ($::init_system == 'systemd') {
    exec { 'stop my-program':
      command => '/bin/systemctl stop my-program || echo "stop failed" >> /tmp/spec-log'
    }
  }

}
