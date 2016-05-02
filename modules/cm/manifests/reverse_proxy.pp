define cm::reverse_proxy(
  $ssl_cert = undef,
  $ssl_key = undef,
  $aliases = [],
  $redirects = undef,
  $upstream_options = { }
) {

  include 'nginx'

  $upstream_options_defaults = {
    name        => 'reverse-proxy-backend',
    members     => ['localhost:443'],
    ssl         => true,
    header_host => '$host',
  }

  $upstream_opts = merge($upstream_options_defaults, $upstream_options)
  $upstream_name_real = $upstream_options[name] ? { default => $upstream_opts[name], undef => $upstream_options_defaults[name] }

  if ($upstream_options[name] == undef) {
    if !(defined(Cm::Upstream::Proxy[$upstream_opts[name]])) {
      cm::upstream::proxy { $upstream_opts[name]:
        members => $upstream_opts[members],
      }
    }
  }

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

  $proto = $upstream_opts[ssl] ? { true => 'https', false => 'http' }
  nginx::resource::vhost { $name:
    server_name         => $hostnames,
    listen_port         => $port,
    ssl                 => $ssl,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      "proxy_set_header Host '${upstream_opts[header_host]}';",
      'proxy_set_header X-Real-IP $remote_addr;',
      "proxy_pass ${proto}://${upstream_name_real};",
      'proxy_next_upstream error timeout http_502;'
    ]
  }

}
