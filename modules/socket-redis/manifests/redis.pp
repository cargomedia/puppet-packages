class socket-redis::redis ($name) {

  require 'redis'

  $redisHost = hiera('ipAddress')

  @@file {"socket-redis::redis config for ${name}":
    content => "REDIS_HOST=${redisHost}\n",
  }
}
