class mongodb::role::shard (
  $port = 27018,
  $bind_ip = '127.0.0.1',
  $repl_set = undef,
  $repl_members = undef
) {

  mongodb::core::mongod {'shard':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    repl_set => $repl_set,
  }

  if $repl_set {
    mongodb_replset {$repl_set:
      ensure => present,
      members => $repl_members,
      require => Mongodb::Core::Mongod['shard'],
    }
  }

}
