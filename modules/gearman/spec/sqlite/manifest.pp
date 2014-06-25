node default {

  class {'gearman::server':
    persistence => 'sqlite3',
  }
}
