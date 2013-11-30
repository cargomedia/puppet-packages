node default {

  require 'monit'

  class {'socket-redis':}
}
