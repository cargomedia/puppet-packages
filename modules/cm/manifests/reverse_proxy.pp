define cm::reverse_proxy(
  $ssl_cert = undef,
  $ssl_key = undef,
  $aliases = [],
  $redirects = undef
) {

  include 'cm::services::upstream_proxy'

  $hostnames = concat([$name], $aliases)
  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)
  $port = $ssl ? { true => 443, false => 80 }

  if ($redirects) {
    $protocol = $ssl ? { true => 'https', false => 'http' }
    nginx::resource::vhost{ "${name}-redirect":
      listen_port         => 80,
      server_name         => $redirects,
      location_cfg_append => [
        "return 301 ${protocol}://${name}\$request_uri;",
      ],
    }
  }

  if ($ssl) {
    nginx::resource::vhost{ "${name}-https-redirect":
      listen_port         => 80,
      server_name         => $hostnames,
      location_cfg_append => [
        'return 301 https://$host$request_uri;',
      ],
    }
  }

  nginx::resource::vhost { $name:
    server_name         => $hostnames,
    ssl                 => $ssl,
    listen_port         => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      "proxy_set_header Host '${name}';",
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_pass https://reverse-proxy-backend;',
      'proxy_next_upstream error timeout http_502;'
    ],
  }

}
