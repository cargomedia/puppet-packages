node default {

  include 'monit'

  mongodb::core::mongod {'config1':
    config_server => true,
    port => 28000,
  }
  ->

  mongodb::core::mongod {'config2':
    config_server => true,
    port => 28001,
  }
  ->

  mongodb::core::mongod {'config3':
    config_server => true,
    port => 28002,
  }
  ->

  mongodb::core::mongod {'arbiter':
    port => 27000,
    shard_server => true,
    repl_set => 'rep1'
  }
  ->

  mongodb::core::mongod {'db1':
    port => 27001,
    shard_server => true,
    repl_set => 'rep1'
  }
  ->

  mongodb::core::mongod {'db2':
    port => 27002,
    shard_server => true,
    repl_set => 'rep1'
  }
  ->

  mongodb::core::mongos {'router1':
    port => 27017,
    config_servers => ['127.0.0.1:28000', '127.0.0.1:28001', '127.0.0.1:28002'],
  }
  ->

  mongodb_replset {'rep1':
    ensure => present,
    members => ['localhost:27001', 'localhost:27002'],
  }
  ->

  exec {"waiting for cluster to be wired":
    command => 'sleep 30',
    provider => shell,
    path => ['/bin']
  }
  ->

  mongodb_shard {'localhost:27001':
    ensure => present,
    repl_set => 'rep1',
    router => 'localhost:27017'
  }

}
