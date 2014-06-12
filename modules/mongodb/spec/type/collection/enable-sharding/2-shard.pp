node default {

  mongodb_collection {'mycollection':
    ensure => present,
    shard => true,
    shard_key => '_id',
    database => 'testdb',
    router => 'localhost:27017'
  }

  mongodb_database {'testdb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }
}
