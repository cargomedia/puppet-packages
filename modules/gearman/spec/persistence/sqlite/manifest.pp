node default {

  class { 'gearman::server':
    persistence => 'sqlite3',
    bind_ip => '127.0.0.1'
  }
}
