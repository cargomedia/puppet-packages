node default {

  class {'apt' :
    before => Class['raid::adaptec'],
  }

  require 'raid::adaptec'
}