class pulsar_rest_api (
  $version = latest,
  $port = 80,
  $internal_port = 8080,

  $mongodb_host = 'localhost',
  $mongodb_port = 27017,
  $mongodb_db = 'pulsar-rest-api',

  $log_dir = '/var/log/pulsar-rest-api',

  $pulsar_repo = undef,
  $pulsar_branch = undef,

  $auth = undef,

  $ssl_cert = undef,
  $ssl_key = undef,
) {

  require pulsar
  require nodejs
  include pulsar_rest_api::service
  include nginx

  user { 'pulsar-rest-api':
    ensure     => present,
    system     => true,
    managehome => true,
    home       => '/home/pulsar-rest-api',
  }

  if $mongodb_host == 'localhost' {
    class { 'mongodb::role::standalone':
      hostname => $mongodb_host,
      port     => $mongodb_port,
    }
  }

  file { '/etc/pulsar-rest-api':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { '/etc/pulsar-rest-api/config.yml':
    ensure  => file,
    content => template('pulsar_rest_api/config.yml'),
    owner   => 'pulsar-rest-api',
    group   => '0',
    mode    => '0440',
    before  => Package['pulsar-rest-api'],
    notify  => [Service['pulsar-rest-api'], Service['nginx']],
  }

  file { $log_dir:
    ensure  => directory,
    owner   => 'pulsar-rest-api',
    group   => 'pulsar-rest-api',
    mode    => '0644',
    before  => Package['pulsar-rest-api'],
  }


  file { '/etc/init.d/pulsar-rest-api':
    ensure  => file,
    content => template("${module_name}/init.sh"),
    owner   => '0',
    group   => '0',
    mode    => '0755',
    before  => Package['pulsar-rest-api'],
    notify  => Service['pulsar-rest-api'],
  }

  package { 'pulsar-rest-api':
    ensure   => $version,
    provider => 'npm',
    require  => Class['nodejs'],
    notify   => Service['pulsar-rest-api'],
  }

  helper::service { 'pulsar-rest-api':
    require => Package['pulsar-rest-api'],
  }

  $ssl = ($ssl_cert != undef) or ($ssl_key != undef)

  nginx::resource::vhost { 'pulsar-rest-api':
    listen_port         => $port,
    ssl                 => $ssl,
    ssl_port            => $port,
    ssl_cert            => $ssl_cert,
    ssl_key             => $ssl_key,
    proxy               => 'http://pulsar-rest-api',
    location_cfg_append => [
      'proxy_set_header X-Real-IP $remote_addr;',
      'proxy_set_header Host $host;',
      'proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;',
      'proxy_http_version 1.1;',
      'proxy_set_header Upgrade $http_upgrade;',
      'proxy_set_header Connection "upgrade";',
      'proxy_read_timeout 999999999;',
      'proxy_buffering off;',
    ],
  }

  nginx::resource::upstream { 'pulsar-rest-api':
    ensure              => present,
    members             => ["localhost:${internal_port}"],
    upstream_cfg_append => ['ip_hash;'],
  }

  logrotate::entry{ $module_name:
    content => template("${module_name}/logrotate")
  }

  @monit::entry { 'pulsar-rest-api':
    content => template("${module_name}/monit"),
    require => Service['pulsar-rest-api'],
  }
}
