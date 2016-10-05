node default {

  class { 'bipbip':
    api_key => 'foo',
  }

  class { 'php5::fpm': }
}
