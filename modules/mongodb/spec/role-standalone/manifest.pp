node default {

  class {'mongodb::role::standalone':
    bind_ip => '127.0.0.1',
  }

}
