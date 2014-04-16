class mongodb::role::arbiter (
  $replica_set,
  $port = 27018,
  $bind_ip = '127.0.0.1'
) {

  mongodb::core::mongod {'arbiter':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    replica_set => $replica_set,
  }

}
