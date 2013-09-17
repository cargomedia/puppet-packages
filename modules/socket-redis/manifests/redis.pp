class socket-redis::redis {

  require 'redis'

  $redisHost = hiera('ipAddress')

  @@file {'socket-redis::redis config':
    content => "REDIS_HOST=${redisHost}\n",
  }
}
