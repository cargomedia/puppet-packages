node default {

  require 'raid::lsi_megaraidsas'
  class { 'bipbip':
    frequency => 0.1,
    log_level => 'DEBUG',
  }
}
