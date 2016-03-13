node default {

  mongodb_database { 'testdb':
    ensure => present,
    shard  => true,
    router => 'localhost:27017',
  }
  ->

  mongodb_user { 'testuser':
    database => 'testdb',
    password => 'my-password',
    roles    => [ { 'role' => 'dbAdmin', 'db' => 'testdb' } ],
  }
  ->

  mongodb_collection { 'foo':
    ensure   => present,
    database => 'testdb',
    router   => 'localhost:27017'
  }
  ->

  mongodb_collection { 'bar':
    ensure    => present,
    database  => 'testdb',
    shard     => true,
    shard_key => '_id',
    router    => 'localhost:27017'
  }
}
