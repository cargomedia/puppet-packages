define jetbrains::application (
  $host,
  $ssl_cert,
  $ssl_key,
  $version,
  $build,
  $port,
  $download_url,
) {

  require 'nginx'

  $user = "jetbrains-${name}"
  $group = "jetbrains-${name}"
  $base_url = "https://${host}"
  $service_name = "jetbrains-${name}"

  $home_path = "/usr/local/jetbrains-${name}"
  $config_path = "${home_path}/conf"
  $var_path = "/var/lib/jetbrains-${name}"

  $installation_uuid = fqdn_uuid("${name}.${host}")

  group { $group:
    ensure => present,
  }

  user { $user:
    ensure  => present,
    groups  => $group,
    require => Group[$group]
  }

  file { [$home_path, $var_path, $config_path, "${config_path}/internal"]:
    ensure  => directory,
    group   => $group,
    owner   => $user,
    require => User[$user],
  }

  helper::script { "install jetbrains-${name}":
    content => template("${module_name}/install_application.sh"),
    unless  => "grep -e '^${version}.${build}$' ${home_path}/${name}.version",
    timeout => 2000,
    before  => Daemon[$service_name],
    require => File[$home_path],
  }

  file { "${config_path}/internal/bundle.properties":
    ensure  => file,
    content => template("${module_name}/app.bundle.properties"),
    before  => Daemon[$service_name],
    require => Helper::Script["install jetbrains-${name}"],
    notify  => Service[$service_name],
  }

  daemon { $service_name:
    binary  => "${home_path}/bin/${name}.sh",
    args    => 'run',
    env     => {
      'HOME' => $var_path
    },
    require => File[$var_path],
  }

  nginx::resource::vhost { "${module_name}-${host}-https-redirect":
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