class socket_redis (
  $version     = 'latest',
  $redisHost   = 'localhost',
  $socketPorts = [8090],
  $statusPort  = '8085',
  $statusToken = undef,
) {

  require 'nodejs'

  if $redisHost == 'localhost' {
    require 'redis'
  }

  user { 'socket-redis':
    ensure => present,
    system => true,
  }

  $arg1 = '/usr/bin/socket-redis'
  $arg2 = "--status-port=${statusPort} --redis-host=${redisHost}"
  $arg3 = inline_template("--socket-ports=<%= @socketPorts.join(',')%>")
  $arg4 = $statusToken ? { undef => '', default => "--status-secret=${statusToken}" }

  daemon { 'socket-redis':
    binary       => '/usr/bin/node',
    args         => "${arg1} ${arg2} ${arg3} ${arg4}",
    user         => 'socket-redis',
    limit_nofile => 10000,
    require      => [Package['socket-redis']],
  }

  package { 'socket-redis':
    ensure   => $version,
    provider => 'npm',
    notify   => Daemon['socket-redis'],
  }

  @bipbip::entry { 'socket-redis':
    plugin  => 'socket-redis',
    options => {
      'url'          => "http://localhost:${statusPort}/status",
      'status_token' => $statusToken,
    },
  }
}
