class mongodb::role::shard (
  $port = 27018,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $repl_set = undef,
  $repl_members = undef,
  $repl_arbiters = undef,
  $router,
  $options = { },
  $auth_key = undef,
  $monitoring_credentials = { },
  $enable_sharding = true,
) {

  mongodb::core::mongod { 'shard':
    port                   => $port,
    bind_ip                => $bind_ip,
    shard_server           => true,
    repl_set               => $repl_set,
    options                => $options,
    auth_key               => $auth_key,
    monitoring_credentials => $monitoring_credentials,
  }

  if $repl_set {
    mongodb_replset { $repl_set:
      ensure   => present,
      members  => $repl_members,
      arbiters => $repl_arbiters,
      require  => Mongodb::Core::Mongod['shard'],
      before   => Mongodb_shard["${hostname}:${port}"]
    }
  }

  if $enable_sharding {
    mongodb_shard { "${hostname}:${port}":
      ensure   => present,
      repl_set => $repl_set,
      router   => $router,
      require  => Mongodb::Core::Mongod['shard'],
    }
  }

}
