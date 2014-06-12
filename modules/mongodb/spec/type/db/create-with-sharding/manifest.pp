node default {

  mongodb::core::mongod {'config':
    config_server => true,
    port => 27019
  }
  ->

  exec {'wait for config server up':
    command => 'while ! (mongo --quiet --host localhost:27019 --eval \'db.getMongo()\'); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }
  ->

  mongodb::core::mongos {'router':
    port => 27017,
    config_servers => ['127.0.0.1:27019'],
  }
  ->

  exec {'wait for router server up':
    command => 'while ! (mongo --quiet --host localhost:27017 --eval \'db.getMongo()\'); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }
  ->

  class {'mongodb::role::shard':
    port => 27018,
    router => 'localhost:27017'
  }
  ->

  mongodb_database {'testdb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }

}
