class socket_redis (
  $version = 'latest',
  $redisHost = 'localhost',
  $socketPorts = [8090],
  $logDir = '/var/log/socket-redis',
  $statusPort = '8085',
) {

  require 'nodejs'

  if $redisHost == 'localhost' {
    require 'redis'
  }

  user { 'socket-redis':
    ensure => present,
    system => true,
  }

  file { $logDir:
    ensure  => directory,
    owner   => 'socket-redis',
    group   => 'socket-redis',
    mode    => '0644',
  }

  logrotate::entry { $module_name:
    path => "${logDir}/*.log",
  }

  $arg1 = '/usr/bin/socket-redis'
  $arg2 = "--log-dir=${logDir} --status-port=${statusPort} --redis-host=${redisHost}"
  $arg3 = inline_template("--socket-ports=<%= @socketPorts.join(',')%>")

  daemon { 'socket-redis':
    binary       => '/usr/bin/node',
    args         => "${arg1} ${arg2} ${arg3}",
    user         => 'socket-redis',
    limit_nofile => 10000,
    require      => [Package['socket-redis'], File[$logDir]],
  }

  package { 'socket-redis':
    ensure   => $version,
    provider => 'npm',
    notify   => Daemon['socket-redis'],
  }

  @bipbip::entry { 'socket-redis':
    plugin  => 'socket-redis',
    options => {
      'url' => "http://localhost:${statusPort}/status",
    },
  }
}
