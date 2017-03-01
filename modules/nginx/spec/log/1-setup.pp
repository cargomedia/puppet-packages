node default {

  host { ['me']:
    ip => '127.0.0.1',
  }

  class { 'nginx':
    log_format => 'slim \'$request $request_body $status\'',
    access_log => 'syslog:server=unix:/dev/log slim',
  }

  # Defining a vhost with upstream is needed to have the $request_body filled

  nginx::resource::vhost { 'spec_vhost':
    ensure              => present,
    server_name         => ['me'],
    listen_port         => '80',
    proxy               => 'http://backend',
    location_cfg_append => [
      'error_page  405     =200 $uri;'
    ]
  }

  nginx::resource::upstream { 'backend':
    ensure  => present,
    members => [
      'localhost:8096',
    ],
  }
}
