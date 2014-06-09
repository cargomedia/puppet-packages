node default {

  class {'mongodb::role::standalone':
    bind_ip => '127.0.0.1',
    port => 27017,
  }
  ->

  exec {'wait for server up':
    command => 'while ! (mongo --quiet --host localhost:27017 --eval \'db.getMongo()\'); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }

}
