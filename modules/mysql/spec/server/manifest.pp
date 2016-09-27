node default {

  class { 'mysql::server':
    root_password             => 'foo',
    debian_sys_maint_password => 'bar',
    key_buffer_size => '8M',
    thread_cache_size => 20,
    max_connections => 10,
  }
}
