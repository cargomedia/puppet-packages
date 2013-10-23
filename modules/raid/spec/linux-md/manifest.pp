node default {

  class {'apt' :
    before => Class['raid::linux-md'],
  }

  require 'raid::linux-md'
}