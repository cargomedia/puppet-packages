node default {

  exec { 'wait for heartbeat':
    command  => '/bin/sleep 60',
    provider => shell,
  }
}
