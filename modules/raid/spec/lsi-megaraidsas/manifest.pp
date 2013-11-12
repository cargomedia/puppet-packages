node default {

  class {'apt' :
    before => Class['raid::lsi-megaraidsas'],
  }

  require 'raid::lsi-megaraidsas'
  require 'monit'
}
