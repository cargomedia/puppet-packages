define mysql::server::instance ($root_password = undef, $debian_sys_maint_password = undef) {

  class {'mysql::server':
    root_password => $root_password,
    debian_sys_maint_password => $debian_sys_maint_password,
  }
}
