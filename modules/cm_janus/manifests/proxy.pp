class cm_janus::proxy(
  $hostname,
  $port,
  $ssl_cert,
  $ssl_key,
  $aliases = [],
){

  include 'nginx'
  include 'cm::services::webserver'
  include 'cm_janus'

  cm::upstream::proxy { 'janus':
    members => ["127.0.0.1:${cm_janus::websockets_listen_port}"]
  }

  $hostnames = concat([$hostname], $aliases)

  nginx::resource::vhost { $hostname:
    server_name         => $hostnames,
    ssl                 => true,
    listen_port         => $port,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'proxy_set_header Host $host;',
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_http_version 1.1;',
      'proxy_pass http://janus;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_read_timeout 999999999;',
      'proxy_buffering off;',
    ],
  }
}
