node default {

  require 'network'

  class { 'network::resolv':
    search     => ['example.local', 'example.com'],
    nameserver => ['172.168.1.2', '8.8.8.8'],
    domain     => 'example.com',
  }
}
