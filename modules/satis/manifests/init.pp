class satis(
  $hostname,
  $ssl_cert,
  $ssl_key,
) {

  require 'composer'
  require 'git'
  include 'nginx'

  $version = '10439c168643bd74d76fc894d61ae3291c999aee'

  file {
    '/etc/satis':
      ensure => 'directory',
      owner  => '0',
      group  => '0',
      mode   => '0755';
    '/usr/local/bin/satis-repo':
      content => template("${module_name}/satis-repo.sh.erb"),
      owner   => '0',
      group   => '0',
      mode    => '0755';
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
    ],
  }
}
