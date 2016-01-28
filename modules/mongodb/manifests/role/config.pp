class mongodb::role::config (
  $port = 27019,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $options = { },
  $key_file_content = undef,
) {

  mongodb::core::mongod { 'config':
    config_server    => true,
    port             => $port,
    bind_ip          => $bind_ip,
    options          => $options,
    key_file_content => $key_file_content,
  }

}
