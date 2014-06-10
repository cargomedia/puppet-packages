class mongodb::role::arbiter (
  $port = 27018,
  $bind_ip = '0.0.0.0',
  $hostname = 'localhost',
  $repl_set,
  $repl_members,
  $options = []
) {

  mongodb::core::mongod {'arbiter':
    port => $port,
    bind_ip => $bind_ip,
    shard_server => true,
    repl_set => $repl_set,
    journal => false,
    options => $options,
  }

  mongodb_replset {$repl_set:
    ensure => present,
    arbiter => "${hostname}:${port}",
    members => $repl_members,
    require => Mongodb::Core::Mongod['arbiter'],
  }

}
