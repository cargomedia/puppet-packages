node default {

  include 'nginx'
  require 'monit'

  cm_janus { 'cm-janus':
    http_server_port    =>  8800,
    http_server_api_key =>  'foobar23',
    cm_api_base_url     => 'http://www.cm.dev',
    cm_api_key          => 'fish',
    cm_application_path => '/home/cm',
    jobs_path           => '/tmp',
  }

  host { 'cm.dev':
    host_aliases => ['www.cm.dev'],
    ip           => '127.0.0.1',
  }

  file { '/tmp/index.html':
    ensure  => file,
    content => '{"success": { "result": {}}}', # workaround with fake cm-app-api https://github.com/cargomedia/puppet-packages/issues/1196
  }

  nginx::resource::vhost { 'proxy-destination':
    server_name         => ['bar.xxx'],
    www_root            => '/tmp',
    require             => File['/tmp/index.html'],
    vhost_cfg_prepend   => [
      'error_page  405  =200 $uri;' # workaround to make nginx accept POST for static files
    ]
  }
}
