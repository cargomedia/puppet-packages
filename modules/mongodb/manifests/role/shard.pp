class mongodb::role::shard (
  $port = 27018,
  $bind_ip = '127.0.0.1',
  $repl_set = ''
) {

  mongodb::core::mongod {'shard':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    repl_set => $repl_set,
  }

}
