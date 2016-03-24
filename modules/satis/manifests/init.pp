class satis(
  $hostname,
  $ssl_cert,
  $ssl_key,
) {

  require 'composer'
  require 'git'
  include 'nginx'

  $version = '68ba9149b30da77ab6d8b37712e5a7d531c5a5f4'

  file { '/etc/satis':
    ensure => 'directory',
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  user { 'satis':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/var/lib/satis',
  }
  ->

  composer::project { 'composer/satis':
    target    => '/var/lib/satis/satis',
    version   => $version,
    stability => 'dev',
    user      => 'satis',
    home      => '/var/lib/satis'
  }
  ->

  file { '/var/lib/satis/public':
    ensure => 'directory',
    owner  => 'satis',
    group  => 'satis',
    mode   => '0755',
  }

  nginx::resource::vhost{ "${module_name}-https-redirect":
    listen_port         => 80,
    ssl                 => false,
    server_name         => [$hostname],
    location_cfg_append => [
      'return 301 https://$host$request_uri;',
    ],
  }

  nginx::resource::vhost { $module_name:
    server_name         => [$hostname],
    listen_port         => 443,
    ssl                 => true,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    location_cfg_append => [
      'root /var/lib/satis/public/;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_types application/json text/plain;',
    ],
  }
}
