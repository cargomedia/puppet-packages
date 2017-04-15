node default {

  class {'cacti::agent::mysql':
    db_host           => 'localhost',
    db_sense_user     => 'sense-cacti',
    db_sense_password => 'sense-cacti',
    require           => Class['mysql::server'],
  }

}