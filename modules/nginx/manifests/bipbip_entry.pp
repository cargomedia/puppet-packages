class nginx::bipbip_entry {

  include 'nginx'

  nginx::resource::vhost{ 'server-status':
    listen_port => 80,
    server_name => ['localhost'],
  }

  nginx::resource::location{ 'server-status':
    vhost               => 'server-status',
    location            => '/server-status',
    stub_status         => true,
    location_cfg_append => [
      'allow 127.0.0.1;',
      'deny	all;',
    ],
  }

  @bipbip::entry { 'nginx':
    plugin  => 'nginx',
    options => {
      'url' => 'http://localhost:80/server-status',
    }
  }
}
