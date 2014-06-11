class mongodb::role::standalone (
  $port = 27017,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $rest = true,
  $options = {}
) {

  mongodb::core::mongod {'standalone':
    port    => $port,
    bind_ip => $bind_ip,
    rest    => $rest,
    options => $options,
  }

}
