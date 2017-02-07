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

  $home_path = '/usr/local/jetbrains-hub'
  $config_path = "${home_path}/conf"
  $var_path = '/var/lib/jetbrains-hub'

  group { $group:
    ensure => present,
    gid    => 2000,
  }

  user { $user:
    ensure  => present,
    gid     => 2000,
    require => Group[$group]
  }

  file { [$home_path, $var_path, $config_path, "${config_path}/internal"]:
    ensure  => directory,
    group   => $group,
    owner   => $user,
    require => User[$user],
  }

  helper::script { 'install jetbrains-hub':
    content => template("${module_name}/install_hub.sh"),
    unless  => "grep -e '^${version}.${build}$' ${home_path}/version.docker.image",
    before  => Daemon[$service_name],
    require => File[$home_path],
  }

  file { "${config_path}/internal/bundle.properties":
    ensure  => file,
    content => template("${module_name}/hub.bundle.properties"),
    before  => Daemon[$service_name],
    require => Helper::Script['install jetbrains-hub'],
    notify  => Service[$service_name],
  }

  daemon { $service_name:
    binary  => "${home_path}/bin/hub.sh",
    args    => 'run',
    env     => {
      'HOME' => $var_path
    },
    require => File[$var_path],
  }

  $upstream_name = 'jetbrains-hub'

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
      'proxy_set_header Host $http_host;',
      'proxy_set_header X-Forwarded-Proto https;',
      "proxy_pass http://localhost:${port};",
    ],
  }
}
