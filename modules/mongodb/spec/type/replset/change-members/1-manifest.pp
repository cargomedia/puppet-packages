node default {

  mongodb::core::mongod {
    'repl_node1':
      port => 27001,
      repl_set => 'my-repl';

    'repl_node2':
      port => 27002,
      repl_set => 'my-repl';

    'repl_arbiter1':
      port => 27003,
      repl_set => 'my-repl';
  }
  ->

  exec {'wait for mongodb':
    command => 'for port in 27001 27002 27003; do while ! (mongo --quiet --host localhost:${port} --eval \'db.getMongo()\'); do sleep 0.5; done; done;',
    provider => shell,
    timeout => 30,
  }
  ->

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27001', 'localhost:27002'],
    arbiters => ['localhost:27003'],
  }

}
