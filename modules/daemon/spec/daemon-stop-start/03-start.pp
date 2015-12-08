node default {

  service { 'my-program':
    provider => $::init_system,
    ensure => 'running',
  }

}
