node default {

  class {'gearmand::server':
    persistence => 'sqlite3',
  }
}
