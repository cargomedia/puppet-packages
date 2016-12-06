node default {

  include 'php5::fpm'

  class { 'nginx': }

}
