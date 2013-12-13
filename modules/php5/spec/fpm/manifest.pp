node default {

  require 'monit'

  class {'php5::fpm':}
}
