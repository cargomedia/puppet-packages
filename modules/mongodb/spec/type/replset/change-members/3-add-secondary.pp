node default {

  mongodb_replset {'my-repl':
    ensure => present,
    members => ['localhost:27002', 'localhost:27004'],
    arbiters => ['localhost:27003'],
  }
  ->

  exec {'wait for UNKNOWN state to disappear':
    command => 'while ! (mongo --quiet --host localhost:27001 --eval "printjson(rs.status())" | grep -qv "UNKNOWN"); do sleep 0.5; done',
    provider => shell,
    timeout => 30,
  }

}
