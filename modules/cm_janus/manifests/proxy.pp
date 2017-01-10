define cm_janus::proxy(
  $hostname,
  $port,
  $upstream_port,
  $ssl_cert = undef,
  $ssl_key = undef,
  $aliases = [],
){

  include 'nginx'

  nginx::resource::upstream { $title:
    ensure              => present,
    members             => ["127.0.0.1:${upstream_port} max_fails=0 fail_timeout=1"],
    upstream_cfg_append => [
      'keepalive 100;',
    ],
  }

  $hostnames = concat([$hostname], $aliases)

  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)
  nginx::resource::vhost { "${hostname} for ${title}":
    name                => $hostname,
    server_name         => $hostnames,
    ssl                 => $ssl,
    listen_port         => $port,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'proxy_set_header Host $host;',
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_http_version 1.1;',
      "proxy_pass http://${title};",
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_read_timeout 999999999;',
      'proxy_buffering off;',
    ],
  }
}
