node default {

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27002'],
    arbiters => ['localhost:27003'],
  }

}
