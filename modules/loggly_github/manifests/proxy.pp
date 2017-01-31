class loggly_github::proxy(
  $hostname,
  $port,
  $upstream_port = $loggly_github::port,
  $ssl_cert,
  $ssl_key,
){

  include 'loggly_github'
  include 'nginx'

  nginx::resource::upstream { 'loggly_github':
    members             => ["127.0.0.1:${upstream_port} max_fails=0 fail_timeout=1"],
    upstream_cfg_append => [
      'keepalive 100;',
    ],
  }

  nginx::resource::vhost { 'loggly_github':
    server_name         => [$hostname],
    listen_port         => $port,
    ssl                 => true,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'proxy_pass http://loggly_github;',
      'proxy_http_version 1.1;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Real-IP $remote_addr;',
    ],
    vhost_cfg_prepend   => [
      'error_page 497 https://$host:$server_port$request_uri;',
    ],
  }

}
