node default {

  # dirty hack: cannot be in step 1-base becasue of resource duplication
  mongodb_replset {'rep1':
    ensure => present,
    arbiter => 'localhost:27000',
    members => ['localhost:27001', 'localhost:27002'],
  }
}
