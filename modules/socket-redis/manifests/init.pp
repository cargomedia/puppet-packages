class socket-redis (
  $version = '0.1.1',
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
  include 'socket-redis::service'

  file {'/etc/socket-redis':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  file {'/etc/socket-redis/ssl':
    ensure => directory,
    owner => '0',
    group => '0',
    mode => '0755',
  }

  if $sslKey {
    $sslKeyFile = '/etc/socket-redis/ssl/cert.key'
    file {$sslKeyFile:
      ensure => file,
      content => $sslKey,
      owner => '0',
      group => '0',
      mode => '0640',
      before => File['/etc/init.d/socket-redis'],
      notify => Service['socket-redis'],
    }
  }

  if $sslCert {
    $sslCertFile = '/etc/socket-redis/ssl/cert.pem'
    file {$sslCertFile:
      ensure => file,
      content => $sslCert,
      owner => '0',
      group => '0',
      mode => '0640',
      before => File['/etc/init.d/socket-redis'],
      notify => Service['socket-redis'],
    }
  }

  if $sslPfx {
    $sslPfxFile = '/etc/socket-redis/ssl/cert.pfx'
    file {$sslPfxFile:
      ensure => file,
      content => $sslPfx,
      owner => '0',
      group => '0',
      mode => '0640',
      before => File['/etc/init.d/socket-redis'],
      notify => Service['socket-redis'],
    }
  }

  if $sslPassphrase {
    $sslPassphraseFile = '/etc/socket-redis/ssl/passphrase'
    file {$sslPassphraseFile:
      ensure => file,
      content => $sslPassphrase,
      owner => '0',
      group => '0',
      mode => '0640',
      before => File['/etc/init.d/socket-redis'],
      notify => Service['socket-redis'],
    }
  }

  user {'socket-redis':
    ensure => present,
    system => true,
  }

  file {'/etc/init.d/socket-redis':
    ensure => file,
    content => template('socket-redis/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['socket-redis'],
    before => Package['socket-redis'],
    require => User['socket-redis'],
  }
  ~>

  exec {'update-rc.d socket-redis defaults':
    path => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    refreshonly => true,
  }


  package {'socket-redis':
    ensure => $version,
    provider => 'npm',
  }

  @monit::entry {'socket-redis':
    content => template('socket-redis/monit'),
    require => Service['socket-redis'],
  }
}
