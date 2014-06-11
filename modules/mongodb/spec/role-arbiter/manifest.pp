node default {

  mongodb::core::mongod {
    'rep1_db1':
      port => 27001,
      repl_set => 'rep1';

    'rep1_db2':
      port => 27002,
      repl_set => 'rep1';
  }
  ->

  exec {'wait for mongod nodes':
    command => 'for port in 27001 27002; do while ! (mongo --quiet --host localhost:${port} --eval \'db.getMongo()\'); do sleep 0.5; done; done;',
    provider => shell,
    timeout => 30,
  }
  ->

  class {'mongodb::role::arbiter':
    port => 27003,
    repl_set => 'rep1',
    repl_members => ['localhost:27001', 'localhost:27002'],
  }
  ->

  exec {'wait for arbiter':
    command => 'for port in 27003; do while ! (mongo --quiet --host localhost:${port} --eval \'db.getMongo()\'); do sleep 0.5; done; done;',
    provider => shell,
    timeout => 30,
  }
}
