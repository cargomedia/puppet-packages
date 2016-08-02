node default {

  mongodb_database { 'dummydb':
    ensure => present,
    shard  => true,
    router => 'localhost:27017',
  }
  ->

  mongodb_user { 'dummyuser':
    database => 'dummydb',
    password => 'my-password2',
    roles    => [ { 'role' => 'dbAdmin', 'db' => 'dummydb' } ],
  }
  ->

  mongodb_collection { 'foo':
    ensure   => present,
    database => 'dummydb',
    router   => 'localhost:27017'
  }
#  ->
#
#  mongodb_collection { 'bar':
#    ensure    => present,
#    database  => 'dummydb',
#    shard     => true,
#    shard_key => '_id',
#    router    => 'localhost:27017'
#  }
}
