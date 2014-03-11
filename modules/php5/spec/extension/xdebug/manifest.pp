node default {

  class {'php5::extension::xdebug':
    remote_host => '127.0.0.1',
    remote_port => '1234',
    remote_autostart => true,
    remote_connect_back => false,
  }
}
