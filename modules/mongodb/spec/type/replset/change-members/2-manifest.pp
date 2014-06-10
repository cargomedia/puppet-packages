node default {

  mongodb::core::mongod {
    'repl_node3':
      port => 27004,
      repl_set => 'my-repl';

    'repl_arbiter2':
      port => 27005,
      repl_set => 'my-repl';
  }
  ->

  exec {'wait for mongodb':
    command => 'for port in 27004 27005; do while ! (mongo --quiet --host localhost:${port} --eval \'db.getMongo()\'); do sleep 0.5; done; done;',
    provider => shell,
    timeout => 30,
  }
  ->

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27002', 'localhost:27004'],
    arbiters => ['localhost:27005'],
  }
}
