node default {

  class {'apt::update':
    before => Class['mysql::server'],
  }

  class {'mysql::server':
    rootPassword => 'foo',
    debianSysMaintPassword => 'bar',
  }
}
