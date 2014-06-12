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

  class {'mongodb::role::arbiter':
    port => 27003,
    repl_set => 'rep1',
    repl_members => ['localhost:27001', 'localhost:27002'],
  }

}
