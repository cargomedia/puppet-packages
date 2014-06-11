node default {

  class {'mongodb::role::standalone':
    port => 27017,
  }
  ->

  exec {'wait for mongodb':
    command => 'while ! (mongo --quiet --host localhost:27017 --eval \'db.getMongo()\'); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }
  ->

  mongodb_database {'testdb':
    ensure => present,
  }
  ->

  mongodb_user {'testuser':
    database => 'testdb',
    password => 'my-password2',
    roles => [ {"role" => "dbAdmin", "db"=> "testdb"} ],
  }

}
