node default {

  exec { 'stop my-program':
    command => '/etc/init.d/my-program stop || echo "stop failed" >> /tmp/spec-log'
  }

}
