node default {

  mongodb::core::mongod {'server':
    port => 28017
  }
  ->

  exec {'wait for server up':
    command => 'while ! (mongo --quiet --host localhost:28017 --eval \'db.getMongo()\'); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }

}
