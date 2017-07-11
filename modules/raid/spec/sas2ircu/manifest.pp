node default {

  require 'raid::sas2ircu'
  class { 'bipbip':
    frequency => 0.1,
    log_level => 'DEBUG',
  }
}
