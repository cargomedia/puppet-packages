class socket_redis (
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

  logrotate::entry { $module_name:
    path => "${logDir}/*.log",
  }

  $arg1 = '/usr/bin/socket-redis'
  $arg2 = "--log-dir=${logDir} --status-port=${statusPort} --redis-host=${redisHost}"
  $arg3 = inline_template("--socket-ports=<%= @socketPorts.join(',')%>")
  if $sslKeyFile { $arg4 = "--ssl-key=${sslKeyFile} " }
  if $sslCertFile { $arg5 = "--ssl-cert=${sslCertFile} " }
  if $sslPfxFile { $arg6 = "--ssl-pfx=${sslPfxFile} " }
  if $sslPassphraseFile { $arg7 = "--ssl-passphrase=${sslPassphraseFile}" }
  $optional_args=" ${arg4}${arg5}${arg6}${arg7}"

  daemon { 'socket-redis':
    binary       => '/usr/bin/node',
    args         => "${arg1} ${arg2} ${arg3}${optional_args}",
    user         => 'socket-redis',
    limit_nofile => 10000,
    require      => Package['socket-redis'],
  }

  package { 'socket-redis':
    ensure   => present,
    provider => 'npm',
    notify   => Service['socket-redis'],
  }

  @bipbip::entry { 'socket-redis':
    plugin  => 'socket-redis',
    options => {
      'url' => "http://localhost:${statusPort}/status",
    },
  }

}
