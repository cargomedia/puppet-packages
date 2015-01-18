class cm::services::webserver(
  $fastcgi_members = ['localhost:9000']
) {

  include 'nginx'

  nginx::resource::vhost{'server-status':
    listen_port => 80,
    server_name => ['localhost'],
  }

  nginx::resource::location{'server-status':
    vhost => 'server-status',
    location => '/server-status',
    stub_status => true,
    location_cfg_append => [
      'allow 127.0.0.1;',
      'deny	all;',
    ],
  }

  $upstream_members = suffix($fastcgi_members, ' max_fails=3 fail_timeout=3')

  nginx::resource::upstream {'fastcgi-backend':
    ensure  => present,
    members => $upstream_members,
    upstream_cfg_append => [
      'keepalive 400;',
    ],
  }

  @bipbip::entry {'nginx':
    plugin => 'nginx',
    options => {
      'url' => 'http://localhost:80/server-status',
    }
  }
}
