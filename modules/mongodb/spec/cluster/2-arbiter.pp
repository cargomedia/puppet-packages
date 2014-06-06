node default {

  mongodb_replset {'rep1':
    ensure => present,
    arbiter => 'localhost:27000',
    members => ['localhost:27001', 'localhost:27002', 'localhost:27000'],
  }
  ->

  mongodb_replset {'rep2':
    ensure => present,
    arbiter => 'localhost:27005',
    members => ['localhost:27005', 'localhost:27006', 'localhost:27007'],
  }
}
