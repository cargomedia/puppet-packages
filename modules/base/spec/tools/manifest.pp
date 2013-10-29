node default {

  class {'apt':
    before => Class['base::tools'],
  }

  require 'base::tools'
}
