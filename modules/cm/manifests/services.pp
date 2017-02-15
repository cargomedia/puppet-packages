class cm::services(
  $ssl_cert,
  $ssl_key,
  $stream_options = { },
) {

  $stream_options_defaults = {
    server_name => [],
    port        => 8090,
  }
  $stream_opts = merge($stream_options_defaults, $stream_options)

  include 'redis'
  include 'mysql::server'
  include 'memcached'
  include 'elasticsearch'
  include 'gearman::server'
  include 'mongodb::role::standalone'

  class { 'cm::services::stream':
    server_name => $stream_opts[server_name],
    port        => $stream_opts[port],
    ssl_cert    => $ssl_cert,
    ssl_key     => $ssl_key,
  }
}
