node default {

  class { 'mysql::server':
    root_password             => 'foo',
    debian_sys_maint_password => 'bar',
    key_buffer_size           => '8M',
    thread_cache_size         => 20,
    max_connections           => 10,
  }

  exec { 'Execute two slow queries':
    command  => 'mysql -e "select sleep (1.1);" -pfoo;mysql -e "select sleep (1.1);" -pfoo',
    user     => 'root',
    path     => ['/usr/local/sbin', '/usr/local/bin', '/usr/sbin', '/usr/bin', '/sbin', '/bin'],
    provider => shell,
    require  => Class['mysql::server'],
  }
}
