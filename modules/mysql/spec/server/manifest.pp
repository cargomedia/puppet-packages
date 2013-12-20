node default {

  class {'apt::update':
    before => Class['mysql::server'],
  }

  class {'mysql::server':
    root_password => 'foo',
    debian_sys_maint_password => 'bar',
  }
}
