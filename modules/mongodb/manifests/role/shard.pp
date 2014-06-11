class mongodb::role::shard (
  $port = 27018,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $repl_set = undef,
  $repl_members = undef,
  $repl_arbiters = undef,
  $router,
  $options = {}
) {

  mongodb::core::mongod {'shard':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    repl_set => $repl_set,
    options => $options,
  }

  if $repl_set {
    mongodb_replset {$repl_set:
      ensure => present,
      members => $repl_members,
      arbiters => $repl_arbiters,
      require => Mongodb::Core::Mongod['shard'],
      before => Mongodb_shard["${hostname}:${port}"]
    }
  }

  mongodb_shard {"${hostname}:${port}":
    ensure => present,
    repl_set => $repl_set,
    router => $router,
    require => Mongodb::Core::Mongod['shard'],
  }

}
