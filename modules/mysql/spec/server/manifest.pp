node default {

  class {'mysql::server':
    root_password => 'foo',
    debian_sys_maint_password => 'bar',
  }
}
