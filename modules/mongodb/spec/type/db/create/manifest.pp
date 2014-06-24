node default {

  class {'mongodb::role::standalone':
    port => 27017,
  }
  ->

  mongodb_database {'testdb':
    ensure => present,
  }

}
