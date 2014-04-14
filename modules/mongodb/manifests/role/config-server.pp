class mongodb::role::config-server (
  $port = 27019,
  $bind_ip = '127.0.0.1'
) {

  mongodb::core::mongod {'config':
    config_server => true,
    port => $port,
    bind_ip => $bind_ip,
  }

}
