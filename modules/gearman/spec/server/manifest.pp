node default {

  require 'monit'

  class {'gearman::server':
    jobretries => 255,
  }

}
