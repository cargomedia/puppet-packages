class cm::services::stream (
  $ssl_key,
  $ssl_cert,
  $port         = 8090,
  $redis_host   = '127.0.0.1',
  $socket_ports = [8091, 8092, 8093, 8094],
  $status_port  = 8085,
  $status_token = undef,
) {

  include 'nginx'

  nginx::resource::vhost { 'stream-server':
    listen_port         => $port,
    ssl                 => true,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    proxy               => 'http://backend-socketredis',
    location_cfg_append => [
      'proxy_set_header Host $host;',
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_http_version 1.1;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_read_timeout 60;',
      'proxy_buffering off;',
    ],
  }

  $stream_members = prefix($socket_ports, 'localhost:')

  nginx::resource::upstream { 'backend-socketredis':
    members             => $stream_members,
    upstream_cfg_append => [
      'ip_hash;',
    ],
  }

  class { 'socket_redis':
    redisHost   => $redis_host,
    socketPorts => $socket_ports,
    statusPort  => $status_port,
    statusToken => $status_token,
  }

  @ufw::application { 'cm-services-stream':
    app_ports => inline_template("${port},${status_port}/tcp"),
  }
}
