node default {

  require 'nodejs'

  package { 'socket-redis':
    provider => 'npm',
    require  => Class['nodejs'],
  }
}
