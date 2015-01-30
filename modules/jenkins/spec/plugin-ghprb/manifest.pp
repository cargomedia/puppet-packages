node default {

  class { 'jenkins':
    hostname => 'example.com'
  }

  class { 'jenkins::plugin::ghprb':
    access_token => 'xxx',
    admin_list   => ['foo', 'bar']
  }
}
