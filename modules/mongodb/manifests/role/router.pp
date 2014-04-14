class mongodb::role::router (
  $config_servers,
  $port = 27017,
  $bind_ip = '127.0.0.1'
) {

  mongodb::core::mongos {'router':
    config_server => $config_servers,
    port => $port,
    bind_ip => $bind_ip
  }

}
