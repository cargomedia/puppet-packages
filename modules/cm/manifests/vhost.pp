define cm::vhost(
  $path,
  $ssl_cert = undef,
  $ssl_key = undef,
  $aliases = [],
  $cdn_origin = undef,
  $debug = false
) {

  include 'cm::services::webserver'

  $hostnames = concat([$name], $aliases)
  $debug_int = $debug ? {true => 1, false => 0}
  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)
  $port = $ssl ? {true => 443, false => 80}

  if ($ssl) {
    nginx::resource::vhost{"${name}-https-redirect":
      listen_port => 80,
      server_name => $hostnames,
      location_cfg_append => [
        'return 301 https://$host$request_uri;',
      ],
    }
  }

  nginx::resource::vhost {$name:
    server_name => $hostnames,
    ssl => $ssl,
    listen_port => $port,
    ssl_cert => $ssl_cert,
    ssl_key => $ssl_key,
    location_cfg_append => [
      'include fastcgi_params;',
      "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
      "fastcgi_param CM_DEBUG ${debug_int};",
      'fastcgi_keep_conn on;',
      'fastcgi_pass fastcgi-backend;',
      'error_page 502 =503 /maintenance;',
    ],
  }

  nginx::resource::location{"${name}-fpm-status":
    vhost => $name,
    ssl => $ssl,
    ssl_only => $ssl,
    location => '/fpm-status',
    location_cfg_append => [
      'deny all;',
    ],
  }

  nginx::resource::location{"${name}-maintenance":
    vhost => $name,
    ssl => $ssl,
    ssl_only => $ssl,
    location => '/maintenance',
    www_root => "${path}/public",
    try_files => ['/maintenance.html', 'something-nonexistent'],
  }

  if ($debug) {
    nginx::resource::location{"${name}-library":
      vhost => $name,
      ssl => $ssl,
      ssl_only => $ssl,
      location => '/library/',
      www_root => $path,
    }

    nginx::resource::location{"${name}-vendor":
      vhost => $name,
      ssl => $ssl,
      ssl_only => $ssl,
      location => '/vendor/',
      www_root => $path,
    }
  }

  if ($cdn_origin) {
    $cdn_origin_vhost = "${name}-origin"

    nginx::resource::vhost{$cdn_origin_vhost:
      server_name => [$cdn_origin],
      ssl => $ssl,
      ssl_cert => $ssl_cert,
      ssl_key => $ssl_key,
      location_cfg_append => [
        'deny all;',
      ],
    }
  } else {
    $cdn_origin_vhost = $name
  }

  nginx::resource::location{"${name}-origin-upstream":
    location => '~* ^/(vendor-css|vendor-js|library-css|library-js|layout)/',
    vhost => $cdn_origin_vhost,
    ssl => $ssl,
    ssl_only => false,
    location_cfg_append => [
      'expires 1y;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_min_length 1000;',
      'gzip_types application/x-javascript text/css text/plain application/xml image/svg+xml;',

      'include fastcgi_params;',
      "fastcgi_param SCRIPT_FILENAME ${path}/public/index.php;",
      "fastcgi_param CM_DEBUG ${debug_int};",
      'fastcgi_keep_conn on;',
      'fastcgi_pass fastcgi-backend;',
    ],
  }

  nginx::resource::location{"${name}-origin-static":
    location => '/static',
    vhost => $cdn_origin_vhost,
    ssl => $ssl,
    ssl_only => false,
    www_root => "${path}/public",
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

  nginx::resource::location{"${name}-origin-userfiles":
    location => '/userfiles',
    vhost => $cdn_origin_vhost,
    ssl => $ssl,
    ssl_only => false,
    www_root => "${path}/public",
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
