class mongodb::role::standalone (
  $port = 27017,
  $bind_ip = '127.0.0.1'
) {

  mongodb::core::mongod {'standalone':
    port => $port,
    bind_ip => $bind_ip,
    rest => true,
  }

}
