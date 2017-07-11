node default {

  require 'raid::adaptec'
  require 'sudo'
  class { 'bipbip':
    frequency => 0.1,
    log_level => 'DEBUG',
  }

}
