class cm::services(
  $ssl_cert = undef,
  $ssl_key = undef,
) {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'elasticsearch'
  include 'gearman::server'
  include 'mongodb::role::standalone'

  cm::upstream::fastcgi {'fastcgi-backend':
  }

  class { 'cm::services::stream':
    ssl_cert => $ssl_cert,
    ssl_key  => $ssl_key,
  }

}
