class mongodb::role::config (
  $port = 27019,
  $bind_ip = '127.0.0.1',
  $hostname = 'localhost'
) {

  mongodb::core::mongod {'config':
    config_server => true,
    port => $port,
    bind_ip => $bind_ip,
  }

}
