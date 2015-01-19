class cm::services {

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'elasticsearch'
  include 'gearman::server'
  include 'cm::services::stream'
  include 'cm::services::webserver'
  include 'mongodb::role::standalone'
}
