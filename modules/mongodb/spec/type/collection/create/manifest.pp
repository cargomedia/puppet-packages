node default {

  class {'mongodb::role::standalone':
    port => 27017,
  }
  ->

  mongodb_collection {'mycollection':
    ensure => present,
    database => 'testdb',
  }

}
