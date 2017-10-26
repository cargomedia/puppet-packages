class jetbrains::youtrack (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '2017.3',
  $build   = '37116',
  $port    = 8081,
  $hub_url = undef,
) {

  jetbrains::application { 'youtrack':
    host         => $host,
    ssl_cert     => $ssl_cert,
    ssl_key      => $ssl_key,
    version      => $version,
    build        => $build,
    port         => $port,
    download_url => "https://download.jetbrains.com/charisma/youtrack-${version}.${build}.zip",
    config       => file("${module_name}/youtrack.config"),
    hub_url      => $hub_url,
  }
  ->

  nginx::resource::location { 'youtrack-apieventSourceBus':
    location => '/api/eventSourceBus',
    ssl => true,
    ssl_only => true,
    vhost => 'jetbrains-youtrack',
    location_cfg_append => [
      'proxy_cache off;',
      'proxy_buffering off;',
      'proxy_read_timeout 86400s;',
      'proxy_send_timeout 86400s;',
      'proxy_set_header Connection "";',
      'chunked_transfer_encoding off;',
      'proxy_set_header X-Forwarded-Host $http_host;',
      'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;',
      'proxy_set_header X-Forwarded-Proto $scheme;',
      "proxy_pass http://localhost:${port};",
    ],
  }
}
