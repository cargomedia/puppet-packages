node default {

  require 'raid::linux_md'
  class { 'bipbip':
    frequency => 0.1,
    log_level => 'DEBUG',
  }
}
