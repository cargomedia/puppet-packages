class jetbrains::hub (
  $host,
  $ssl_cert,
  $ssl_key,
  $version = '2.5',
  $build   = '450',
  $port    = 8080,
) {

  require 'jetbrains::common'

  $user = 'jetbrains-hub'
  $group = 'jetbrains-hub'
  $base_url = "https://${host}"
  $service_name = 'jetbrains-hub'

  group { $group:
    ensure => present,
    gid    => 2000,
  }

  user { $user:
    ensure  => present,
    gid     => 2000,
    require => Group[$group]
  }

  file { ['/var/lib/hub', '/usr/local/hub', '/usr/local/hub/conf', '/usr/local/hub/conf/internal']:
    ensure  => directory,
    group   => $group,
    owner   => $user,
    require => User[$user],
  }

  helper::script { 'install jetbrains-hub':
    content => template("${module_name}/install_hub.sh"),
    unless  => "grep -e '^${version}.${build}$' /usr/local/hub/version.docker.image",
    before  => Daemon[$service_name],
    require => File['/var/lib/hub', '/usr/local/hub'],
  }

  file { '/usr/local/hub/conf/internal/bundle.properties':
    ensure  => file,
    content => template("${module_name}/hub.bundle.properties"),
    before  => Daemon[$service_name],
    require => Helper::Script['install jetbrains-hub'],
    notify  => Service[$service_name],
  }

  daemon { $service_name:
    binary => '/usr/local/hub/bin/hub.sh',
    args   => 'run',
    env    => {
      'HOME' => '/var/lib/hub'
    },
  }

  $upstream_name = 'jetbrains-hub'

  nginx::resource::upstream { $upstream_name:
    members             => ["localhost:${port}"],
    upstream_cfg_append => [
      'keepalive 100;',
    ],
  }

  nginx::resource::vhost { "${module_name}-https-redirect":
    listen_port         => 80,
    ssl                 => false,
    server_name         => [$host],
    location_cfg_append => [
      'return 301 https://$host$request_uri;',
    ],
  }

  nginx::resource::vhost { "${module_name}-${host}":
    server_name         => [$host],
    listen_port         => 443,
    ssl                 => true,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    ssl_port            => 443,
    location_cfg_append => [
      "proxy_pass http://${upstream_name};",
    ],
  }
}
