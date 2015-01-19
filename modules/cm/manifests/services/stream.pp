class cm::services::stream(
  $port = 8090,
  $ssl_cert = undef,
  $ssl_key = undef,
  $redis_host = '127.0.0.1',
  $socket_ports = [8091, 8092, 8093, 8094],
  $status_port = 8085
) {

  include 'nginx'

  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)

  nginx::resource::vhost {'stream-server':
    listen_port       => $port,
    ssl               => $ssl,
    ssl_port          => $port,
    ssl_cert          => $ssl_cert,
    ssl_key           => $ssl_key,
    proxy             => 'http://backend-socketredis',
    location_cfg_append => [
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;',
      'proxy_http_version 1.1;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_read_timeout 999999999;',
      'proxy_buffering off;',
    ],
  }

  $stream_members = prefix($socket_ports, 'localhost:')

  nginx::resource::upstream {'backend-socketredis':
    ensure  => present,
    members => $stream_members,
    upstream_cfg_append => [
      'ip_hash;',
    ],
  }

  class {'socket_redis':
    redisHost => $redis_host,
    socketPorts => $socket_ports,
    statusPort => $status_port,
  }
}
