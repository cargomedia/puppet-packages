node default {

  include 'nginx'

  cm::services::janus { 'standalone':
    hostname              => 'foohost',
    http_server_api_key   => 'janus-fish',
    http_server_port      => 8100,
    websocket_server_port => 8110,

    ssl_cert              => template('cm/spec/spec-ssl.pem'),
    ssl_key               => template('cm/spec/spec-ssl.key'),

    cm_application_path   => '/home/cm',
    cm_api_base_url       => 'http://www.cm-api.dev',
    cm_api_key            => 'cm-fish',

    rtpbroadcast_minport  => 8400,
    rtpbroadcast_maxport  => 9000,
    require               => Nginx::Resource::Vhost['cm-api-mock'],
  }

  host { 'cm-api.dev':
    host_aliases => ['www.cm-api.dev'],
    ip           => '127.0.0.1',
  }

  file { '/tmp/index.html':
    ensure  => file,
    content => '{"success": { "result": {}}}', # workaround with fake cm-app-api https://github.com/cargomedia/puppet-packages/issues/1196
  }

  nginx::resource::vhost { 'cm-api-mock':
    server_name         => ['cm-api.dev'],
    www_root            => '/tmp',
    vhost_cfg_prepend   => [
      'error_page  405  =200 $uri;' # workaround to make nginx accept POST for static files
    ],
    require             => [
      File['/tmp/index.html'],
      Host['cm-api.dev'],
    ]
  }
}
