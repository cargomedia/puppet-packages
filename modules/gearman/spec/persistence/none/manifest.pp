node default {

  class { 'gearman::server':
    persistence => 'none',
  }

  include 'monit'
}
