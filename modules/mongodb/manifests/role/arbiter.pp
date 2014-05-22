class mongodb::role::arbiter (
  $repl_set,
  $port = 27018,
  $bind_ip = '127.0.0.1'
) {

  mongodb::core::mongod {'arbiter':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    repl_set => $repl_set,
  }

  mongodb_replset {$repl_set:
    ensure => present
  }

}
