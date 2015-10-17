define cm::vhost(
  $path,
  $ssl_cert = undef,
  $ssl_key = undef,
  $aliases = [],
  $redirects = undef,
  $cdn_origin = undef,
  $debug = false,
  $upstream_options = {},
) {

  include 'cm::services::webserver'

  $upstream_options_defaults = {
    name => 'fastcgi-backend',
    members => ['localhost:9000']
  }

  $upstream_opts = merge($upstream_options_defaults, $upstream_options)
  $upstream_name_real = $upstream_options[name] ? { default => $upstream_opts[name], undef => $upstream_options_defaults[name] }

  if ($upstream_options[name] == undef) {
    if !(defined(Cm::Upstream::Fastcgi[$upstream_opts[name]])) {
      cm::upstream::fastcgi { $upstream_opts[name]:
        members => $upstream_opts[members]
      }
    }
  }

  $hostnames = concat([$name], $aliases)
  $debug_int = $debug ? { true => 1, false => 0 }
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
      'include fastcgi_params;',
      'set $_real_client_ip $remote_addr;',
      'if ($http_x_real_ip != "") {',
      '  set $_real_client_ip $http_x_real_ip;',
      '}',
      'fastcgi_param REMOTE_ADDR $_real_client_ip;',
      "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
      "fastcgi_param CM_DEBUG ${debug_int};",
      'fastcgi_keep_conn on;',
      "fastcgi_pass ${upstream_name_real};",
      'error_page 502 =503 /maintenance;',
    ],
  }

  nginx::resource::location{ "${name}-maintenance":
    vhost     => $name,
    ssl       => $ssl,
    ssl_only  => $ssl,
    location  => '/maintenance',
    www_root  => "${path}/public",
    try_files => ['/maintenance.html', 'something-nonexistent'],
  }


  if ($cdn_origin) {
    $cdn_origin_vhost = "${name}-origin"

    nginx::resource::vhost{ $cdn_origin_vhost:
      server_name         => [$cdn_origin],
      ssl                 => $ssl,
      ssl_cert            => $ssl_cert,
      ssl_key             => $ssl_key,
      location_cfg_append => [
        'deny all;',
      ],
    }
  } else {
    $cdn_origin_vhost = $name
  }

  nginx::resource::location{ "${name}-origin-upstream":
    location            => '~* ^/(vendor-css|vendor-js|library-css|library-js|layout)/',
    vhost               => $cdn_origin_vhost,
    ssl                 => $ssl,
    ssl_only            => false,
    location_cfg_append => [
      'expires 1y;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_min_length 1000;',
      'gzip_types application/x-javascript text/css text/plain application/xml image/svg+xml;',

      'include fastcgi_params;',
      'set $_real_client_ip $remote_addr;',
      'if ($http_x_real_ip != "") {',
      '  set $_real_client_ip $http_x_real_ip;',
      '}',
      'fastcgi_param REMOTE_ADDR $_real_client_ip;',
      "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
      "fastcgi_param CM_DEBUG ${debug_int};",
      'fastcgi_keep_conn on;',
      "fastcgi_pass ${upstream_name_real};",
    ],
  }

  nginx::resource::location{ "${name}-origin-static":
    location            => '/static',
    vhost               => $cdn_origin_vhost,
    ssl                 => $ssl,
    ssl_only            => false,
    www_root            => "${path}/public",
    location_cfg_append => [
      'expires 1y;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_min_length 1000;',
      'gzip_types application/x-javascript text/css text/plain application/xml image/svg+xml;',

      'add_header	Access-Control-Allow-Origin	*;',
    ],
  }

  nginx::resource::location{ "${name}-origin-userfiles":
    location            => '/userfiles',
    vhost               => $cdn_origin_vhost,
    ssl                 => $ssl,
    ssl_only            => false,
    www_root            => "${path}/public",
    location_cfg_append => [
      'expires 1y;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_min_length 1000;',
      'gzip_types application/x-javascript text/css text/plain application/xml image/svg+xml;',
    ],
  }
}
