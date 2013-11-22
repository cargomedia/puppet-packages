node default {

  require 'monit'

  class {'mysql::proxy':}
}
