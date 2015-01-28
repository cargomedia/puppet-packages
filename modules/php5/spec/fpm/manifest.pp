node default {

  require 'monit'

  class { 'bipbip':
    api_key => 'foo',
  }

  class { 'php5::fpm': }
}
