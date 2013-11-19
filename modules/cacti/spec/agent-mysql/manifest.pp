node default {

  class {'cacti::agent::mysql':
    dbHost => 'localhost',
    dbSenseUser => 'sense-cacti',
    dbSensePassword => 'sense-cacti',
    require => Class['mysql::server'],
  }
}