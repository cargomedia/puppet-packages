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

  mongodb::core::mongod {'shard1':
    port => 27000,
    shard_server => true,
  }
  ->

  mongodb::core::mongod {'shard2':
    port => 27001,
    shard_server => true,
  }
  ->

  mongodb::core::mongos {'router1':
    config_servers => ['127.0.0.1:28000', '127.0.0.1:28001', '127.0.0.1:28002'],
  }
  ->

  mongodb_shard {['localhost:27000', 'localhost:27001']:
    ensure => present,
    router => 'localhost:27017'
  }
  ->

  mongodb_database {'testdb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }
  ->

  mongodb_user {'testuser':
    database => 'testdb',
    password_hash => 'password',
    roles => [ {"role" => "dbAdmin", "db"=> "testdb"} ],
    router => 'localhost:27017',
  }
  ->

  mongodb_collection {'__all__':
    ensure => present,
    database => 'testdb',
    shard_enabled => true,
    shard_key => '_id',
    router => 'localhost:27017'
  }

}
