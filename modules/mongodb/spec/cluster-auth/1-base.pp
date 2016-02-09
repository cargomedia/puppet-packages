node default {

  include 'monit'

  $auth_key = 'superpassword'

  mongodb::core::mongod { 'config1':
    config_server => true,
    port          => 28000,
    auth_key      => $auth_key,
  }
  ->

  mongodb::core::mongod { 'config2':
    config_server => true,
    port          => 28001,
    auth_key      => $auth_key,
  }
  ->

  mongodb::core::mongod { 'config3':
    config_server => true,
    port          => 28002,
    auth_key      => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep1_arbiter':
    port         => 27000,
    shard_server => true,
    repl_set     => 'rep1',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep1_db1':
    port         => 27001,
    shard_server => true,
    repl_set     => 'rep1',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep1_db2':
    port         => 27002,
    shard_server => true,
    repl_set     => 'rep1',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep2_arbiter':
    port         => 27005,
    shard_server => true,
    repl_set     => 'rep2',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep2_db1':
    port         => 27006,
    shard_server => true,
    repl_set     => 'rep2',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongod { 'rep2_db2':
    port         => 27007,
    shard_server => true,
    repl_set     => 'rep2',
    auth_key     => $auth_key,
  }
  ->

  mongodb::core::mongos { 'router1':
    port           => 27017,
    config_servers => ['127.0.0.1:28000', '127.0.0.1:28001', '127.0.0.1:28002'],
    auth_key       => $auth_key,
  }
  ->

  mongodb_replset { 'rep1':
    ensure   => present,
    members  => ['localhost:27001', 'localhost:27002'],
    arbiters => ['localhost:27000'],
  }
  ->

  mongodb_replset { 'rep2':
    ensure   => present,
    members  => ['localhost:27006', 'localhost:27007'],
    arbiters => ['localhost:27005'],
  }
  ->

  mongodb_shard { 'localhost:27002':
    ensure   => present,
    repl_set => 'rep1',
    router   => 'localhost:27017'
  }
  ->

  mongodb_shard { 'localhost:27007':
    ensure   => present,
    repl_set => 'rep2',
    router   => 'localhost:27017'
  }

}
