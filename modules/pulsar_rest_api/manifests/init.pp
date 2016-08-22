class pulsar_rest_api (
  $version = latest,
  $port = 8080,

  $mongodb_host = 'localhost',
  $mongodb_port = 27017,
  $mongodb_db = 'pulsar-rest-api',

  $log_dir = '/var/log/pulsar-rest-api',
  $config_file = '/etc/pulsar-rest-api/config.yml',

  $pulsar_repo = undef,
  $pulsar_branch = undef,

  $authentication = undef,
) {

  require bower
  require pulsar
  require nodejs

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
      before   => Daemon['pulsar-rest-api'],
    }
  }

  file { '/etc/pulsar-rest-api':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0644',
  }

  file { $config_file:
    ensure  => file,
    content => template('pulsar_rest_api/config.yml'),
    owner   => 'pulsar-rest-api',
    group   => '0',
    mode    => '0440',
    before  => Package['pulsar-rest-api'],
    notify  => Daemon['pulsar-rest-api'],
  }

  file { $log_dir:
    ensure  => directory,
    owner   => 'pulsar-rest-api',
    group   => 'pulsar-rest-api',
    mode    => '0644',
    before  => Package['pulsar-rest-api'],
  }

  package { 'pulsar-rest-api':
    ensure   => $version,
    provider => 'npm',
    require  => Class['nodejs'],
    notify   => [
      Daemon['pulsar-rest-api'],
      Exec['pulsar-rest-api bower install']
    ],
  }

  exec { 'pulsar-rest-api bower install':
    command     => 'bower install --config.interactive=false --production --allow-root',
    cwd         => '/usr/lib/node_modules/pulsar-rest-api',
    path        => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    subscribe   => Package['pulsar-rest-api'],
    refreshonly => true,
  }

  daemon { 'pulsar-rest-api':
    binary  => '/usr/bin/node',
    args    => "/usr/bin/pulsar-rest-api -c ${config_file}",
    user    => 'pulsar-rest-api',
    require => [
      User['pulsar-rest-api'],
      Package['pulsar-rest-api'],
      Exec['pulsar-rest-api bower install']
    ],
  }

  logrotate::entry { $module_name:
    path    => "${log_dir}/*.log",
  }

}
