class mongodb::role::config (
  $port = 27019,
  $bind_ip = '0.0.0.0'
) {

  mongodb::core::mongod {'config':
    config_server => true,
    port => $port,
    bind_ip => $bind_ip,
  }

}
