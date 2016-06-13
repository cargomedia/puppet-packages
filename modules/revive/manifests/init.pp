class revive (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '3.1.0',
  $dbName = 'revive',
  $dbUser = 'revive',
  $dbPassword = 'revive'
) {

  if $::facts['lsbdistcodename'] == 'wheezy' {
    require 'dotdeb' # Revive requires php 5.4.20+
    require 'php5::extension::opcache'
  }
  require 'php5'
  require 'php5::fpm'
  require 'php5::extension::apcu'
  require 'php5::extension::mysql'
  require 'php5::extension::gd'
  require 'mysql::server'
  require 'rsync'
  include 'nginx'

  helper::script { 'install revive':
    content => template("${module_name}/install.sh"),
    unless  => "grep -w \"define('VERSION', '${version}')\" /var/revive/constants.php",
    require => Class['rsync'],
  }

  file { '/var/revive/www/delivery/ajs-proxy.php':
    ensure  => present,
    content => template("${module_name}/ajs-proxy.php"),
    group   => 'www-data',
    owner   => 'www-data',
    mode    => '0644',
    require => Helper::Script['install revive'],
  }

  mysql::user { "${dbUser}@localhost":
    password => $dbPassword,
  }

  mysql::database { $dbName:
    user => "${dbUser}@localhost",
  }

  nginx::resource::vhost{ "${module_name}-https-redirect":
    listen_port         => 80,
    ssl                 => false,
    server_name         => [$host],
    location_cfg_append => [
      'return 301 https://$host$request_uri;',
    ],
  }

  nginx::resource::vhost { $module_name:
    server_name         => [$host],
    listen_port         => 443,
    ssl                 => true,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    ssl_port            => 443,
    location_cfg_append => [
      'root /var/revive/www;',
      'index index.php;',
      'gzip on;',
      'gzip_proxied any;',
      'gzip_http_version 1.0;',
      'gzip_types application/x-javascript text/css text/plain application/xml image/svg+xml;',
    ],
  }

  nginx::resource::location { "${module_name}-php":
    location            => '~ \.php$',
    vhost               =>  $module_name,
    ssl                 =>  true,
    ssl_only            => true,
    location_cfg_append => [
      'root /var/revive/www;',
      'index index.php;',
      'include fastcgi_params;',
      'fastcgi_index index.php;',
      'fastcgi_param PHP_VALUE "include_path=.:/var/revive/lib/pear/";',
      'fastcgi_pass localhost:9000;',
    ],
  }

  cron { "cron revive maintenance ${host}":
    command => "php /var/revive/scripts/maintenance/maintenance.php ${host}",
    user    => 'root',
    minute  => 10,
  }

}
