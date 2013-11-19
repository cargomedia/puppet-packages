node default {

  class {'cacti::extension::mysql::grant':
    require => Class['mysql::server'],
  }
}