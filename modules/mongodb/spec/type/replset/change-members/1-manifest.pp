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

    'repl_node3':
      port => 27004,
      repl_set => 'my-repl';

    'repl_arbiter2':
      port => 27005,
      repl_set => 'my-repl';
  }
  ->

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27001', 'localhost:27002'],
    arbiters => ['localhost:27003'],
  }
  ->

  exec {'wait for secondary':
    command => 'while ! (mongo --quiet --host localhost:27001 --eval "printjson(rs.status())" | grep "SECONDARY"); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }

}
