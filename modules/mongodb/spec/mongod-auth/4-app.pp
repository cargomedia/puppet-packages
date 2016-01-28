node default {

  mongodb_database { 'testdb':
    ensure => present,
    router => 'localhost:27017',
  }
  ->

  mongodb_user { 'basicuser':
    database => 'testdb',
    password => 'my-password',
    roles    => [ { 'role' => 'dbAdmin', 'db' => 'testdb' } ],
  }
  ->

  mongodb_collection { 'foo':
    ensure   => present,
    database => 'testdb',
    router   => 'localhost:27017',
  }
  ->

  mongodb_collection { 'bar':
    ensure    => present,
    database  => 'testdb',
    router    => 'localhost:27017',
  }
}
