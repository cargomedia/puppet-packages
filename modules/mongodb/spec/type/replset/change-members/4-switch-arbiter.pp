node default {

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27002', 'localhost:27004'],
    arbiters => ['localhost:27005'],
  }

}
