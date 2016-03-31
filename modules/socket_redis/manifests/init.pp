class socket_redis (
  $version = 'latest',
  $redisHost = 'localhost',
  $socketPorts = [8090],
  $logDir = '/var/log/socket-redis',

  $statusPort = '8085',
  $sslKey = undef,
  $sslCert = undef,
  $sslPfx = undef,
  $sslPassphrase = undef
) {

  require 'nodejs'
  if $redisHost == 'localhost' {
    require 'redis'
  }
  include 'socket_redis::service'

  file { '/etc/socket-redis':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  file { '/etc/socket-redis/ssl':
    ensure => directory,
    owner  => '0',
    group  => '0',
    mode   => '0755',
  }

  if $sslKey {
    $sslKeyFile = '/etc/socket-redis/ssl/cert.key'
    file { $sslKeyFile:
      ensure  => file,
      content => $sslKey,
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/socket-redis'],
      notify  => Service['socket-redis'],
    }
  }

  if $sslCert {
    $sslCertFile = '/etc/socket-redis/ssl/cert.pem'
    file { $sslCertFile:
      ensure  => file,
      content => $sslCert,
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/socket-redis'],
      notify  => Service['socket-redis'],
    }
  }

  if $sslPfx {
    $sslPfxFile = '/etc/socket-redis/ssl/cert.pfx'
    file { $sslPfxFile:
      ensure  => file,
      content => $sslPfx,
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/socket-redis'],
      notify  => Service['socket-redis'],
    }
  }

  if $sslPassphrase {
    $sslPassphraseFile = '/etc/socket-redis/ssl/passphrase'
    file { $sslPassphraseFile:
      ensure  => file,
      content => $sslPassphrase,
      owner   => '0',
      group   => '0',
      mode    => '0640',
      before  => File['/etc/init.d/socket-redis'],
      notify  => Service['socket-redis'],
    }
  }

  user { 'socket-redis':
    ensure => present,
    system => true,
  }

  file { $logDir:
    ensure  => directory,
    owner   => 'socket-redis',
    group   => 'socket-redis',
    mode    => '0755',
    require => User['socket-redis']
  }

  logrotate::entry{ $module_name:
    path               => "${logDir}/*.log",
    versions_to_keep   => 12,
    rotation_newfile   => 'copytruncate',
    require            => File[$log_dir],
  }


  sysvinit::script { 'socket-redis':
    content           => template("${module_name}/init.sh"),
    require           => [Package['socket-redis'], User['socket-redis']],
  }

  package { 'socket-redis':
    ensure   => $version,
    provider => 'npm',
    notify   => Service['socket-redis'],
  }

  @monit::entry { 'socket-redis':
    content => template("${module_name}/monit"),
    require => Service['socket-redis'],
  }

  @bipbip::entry { 'socket-redis':
    plugin  => 'socket-redis',
    options => {
      'url' => "http://localhost:${statusPort}/status",
    },
  }

}
