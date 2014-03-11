node default {

  class {'mysql::server':
    root_password => 'foo2',
    debian_sys_maint_password => 'bar2',
  }

}
