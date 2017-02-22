define cm::reverse_proxy(
  $ssl_cert,
  $ssl_key,
  $ssl_port = 443,
  $aliases = [],
  $redirects = undef,
  $cdn_origin = undef,
  $upstream_members = ['localhost:443'],
  $upstream_protocol = 'https',
) {

  include 'nginx'

  $backend_name = "${name}-proxy-backend"

  cm::upstream::proxy { $backend_name:
    members => $upstream_members,
  }

  if ($cdn_origin) {
    $hostnames = concat([$name, $cdn_origin], $aliases)
  } else {
    $hostnames = concat([$name], $aliases)
  }

  if ($redirects) {
    nginx::resource::vhost{ "${name}-redirect":
      listen_port         => 80,
      server_name         => $redirects,
      location_cfg_append => [
        "return 301 https://${name}\$request_uri;",
      ],
    }
  }

  nginx::resource::vhost{ "${name}-https-redirect":
    listen_port         => 80,
    server_name         => $hostnames,
    location_cfg_append => [
      'return 301 https://$host$request_uri;',
    ],
  }

  nginx::resource::vhost { $name:
    server_name         => $hostnames,
    listen_port         => $ssl_port,
    ssl                 => true,
    ssl_port            => $ssl_port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'real_ip_recursive on;',
      'real_ip_header X-Real-IP;',
      'set_real_ip_from 0.0.0.0/0;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Real-IP $remote_addr;',
      "proxy_pass ${upstream_protocol}://${backend_name};",
      'proxy_next_upstream error timeout http_502;'
    ]
  }
}
