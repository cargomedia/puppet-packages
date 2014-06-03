node default {

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
