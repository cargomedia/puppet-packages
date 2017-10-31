define cm::reverse_proxy (
  $ssl_cert          = undef,
  $ssl_key           = undef,
  $listen_port       = 80,
  $ssl_port          = 443,
  $ssl_only          = true,
  $aliases           = [],
  $redirects         = undef,
  $cdn_origin        = undef,
  $upstream_members  = ['localhost:443'],
  $upstream_protocol = 'https',
) {

  include 'nginx'

  $backend_name = "${name}-proxy-backend"
  $ssl_enabled = (is_integer($ssl_port) and $ssl_port > 0)
  $ssl_only_final = $ssl_enabled and $ssl_only

  cm::upstream::proxy { $backend_name:
    members => $upstream_members,
  }

  if ($cdn_origin) {
    $hostnames = concat([$name, $cdn_origin], $aliases)
  } else {
    $hostnames = concat([$name], $aliases)
  }

  if ($redirects) {

    $protocol = $ssl_only_final ? {
      true    => 'https',
      default => '\$scheme',
    }

    nginx::resource::vhost { "${name}-redirect":
      listen_port         => $listen_port,
      server_name         => $redirects,
      location_cfg_append => [
        "return 301 ${protocol}://${name}\$request_uri;",
      ],
    }
  }

  if ($ssl_only_final) {
    nginx::resource::vhost { "${name}-https-redirect":
      listen_port         => $listen_port,
      server_name         => $hostnames,
      location_cfg_append => [
        'return 301 https://$host$request_uri;',
      ],
    }
  }

  # This construct is needed due to vhost considering itself SSL-only if
  # both $listen_port and $ssl_port are equal
  $listen_port_argument_vhost = $ssl_only_final ? {
    true => $ssl_port,
    default => $listen_port,
  }

  nginx::resource::vhost { $name:
    server_name         => $hostnames,
    listen_port         => $listen_port_argument_vhost,
    ssl                 => $ssl_enabled,
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
      'proxy_next_upstream error timeout http_502 http_503 invalid_header;',
      'proxy_next_upstream_timeout 5;'
    ]
  }
}
