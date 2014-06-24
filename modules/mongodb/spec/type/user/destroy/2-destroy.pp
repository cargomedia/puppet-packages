node default {

  mongodb_user {'testuser':
    ensure => absent,
    database => 'testdb',
  }

}
