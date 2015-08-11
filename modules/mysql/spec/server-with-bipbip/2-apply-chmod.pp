node default {

  require 'bipbip'

  class { 'mysql::server':
    notify => Service[bipbip],
  }
}
