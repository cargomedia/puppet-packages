node default {

  require 'monit'

  class {'gearman::server':
  }

}
