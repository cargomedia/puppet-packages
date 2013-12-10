node default {

  class {'bipbip':
    api_key => 'mykey',
    frequency => 5,
  }

  bipbip::entry {'memcache':
    plugin => 'Memcached',
    options => {
      "hostname" => "localhost",
      "port" => "6379"
    }
  }
}
