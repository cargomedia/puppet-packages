node default {

  mongodb_database {'dummydb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }
  ->

  mongodb_user {'dummyuser':
    database => 'dummydb',
    password => 'my-password2',
    roles => [ {"role" => "dbAdmin", "db"=> "dummydb"} ],
  }
  ->

  mongodb_collection {'boo':
    ensure => present,
    database => 'dummydb',
    router => 'localhost:27017'
  }
  ->

  mongodb_collection {'dummydb.all':
    ensure => present,
    database => 'dummydb',
    shard_enabled => true,
    shard_key => '_id',
    router => 'localhost:27017'
  }
}
