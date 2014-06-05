class mongodb::role::shard (
  $port = 27018,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $repl_set = undef,
  $repl_members = undef,
  $router = undef,
  $options = []
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
      require => Mongodb::Core::Mongod['shard'],
    }
  }

  # only replica PRIMARY is able to add itself as shard to mongos
  if $router {
    mongodb_shard {"${hostname}:${port}":
      ensure => present,
      repl_set => $repl_set,
      router => $router
    }
  }

}
