node default {

  require 'raid::hpssacli'
  class { 'bipbip':
    frequency => 0.1,
    log_level => 'DEBUG',
  }
}
