class mongodb::role::standalone (
  $port = 27017,
  $bind_ip = undef,
  $rest = true,
  $options = []
) {

  mongodb::core::mongod {'standalone':
    port    => $port,
    bind_ip => $bind_ip,
    rest    => $rest,
    options => $options,
  }

}
