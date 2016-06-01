node default {

  require 'bipbip'

  class { 'mysql::server':
  }

}
