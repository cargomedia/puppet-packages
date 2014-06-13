node default {

  mongodb_database {'testdb':
    ensure => present,
    shard => true,
    router => 'localhost:27017',
  }

}
