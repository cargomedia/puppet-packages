class socket-redis (
  $name,
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

  File <<| title == "socket-redis::redis config for ${name}" |>> {
    path => '/etc/socket-redis/config',
    ensure => file,
    owner => '0',
    group => '0',
    mode => '0644',
    before => File['/etc/init.d/socket-redis'],
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

  file {'/etc/init.d/socket-redis':
    ensure => file,
    content => template('socket-redis/init.sh'),
    owner => '0',
    group => '0',
    mode => '0755',
    notify => Service['socket-redis'],
  }
  ->

  package {'socket-redis':
    ensure => $version,
    provider => 'npm',
  }

  monit::entry {'socket-redis':
    content => template('socket-redis/monit'),
  }
}
