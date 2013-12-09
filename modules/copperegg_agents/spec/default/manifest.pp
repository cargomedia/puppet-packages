node default {

  class {'copperegg_agents':
    api_key => 'mykey',
    frequency => 5,
    services => {
      "memcached" => {
        "name" => "Memcached",
        "servers" => [
          {
            "hostname" => "localhost",
            "port" => 1123
          },
          {
            "hostname" => "localhost",
            "port" => 1123
          }
        ]
      },
      "apache" => {
        "name" => "Apache",
        "servers" => [
          {
            "hostname" => "localhost",
            "port" => 80
          }
        ]
      }
    }
  }

}
