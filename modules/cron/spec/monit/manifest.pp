node default {

  class {'apt':
    before => Class['cron'],
  }

  require 'cron'
  require 'monit'
}
