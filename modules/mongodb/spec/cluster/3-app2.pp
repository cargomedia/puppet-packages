node default {

  mongodb_database {'dummydb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }
  ->

  mongodb_user {'dummyuser':
    database => 'dummydb',
    password_hash => 'password',
    roles => [ {"role" => "dbAdmin", "db"=> "testddummydb"} ],
  }
  ->

  mongodb_collection {'__all__':
    ensure => present,
    database => 'dummydb',
    shard_enabled => true,
    shard_key => '_id',
    router => 'localhost:27017'
  }
}
