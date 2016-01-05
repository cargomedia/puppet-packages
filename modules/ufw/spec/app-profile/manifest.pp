node default {

  ufw::application{ 'foo':
    app_description => 'weird server',
    app_ports => '21,23:25/tcp|10000:15000/udp',
  }
  ->

  ufw::rule {'allow foo':
    app_or_port => 'foo',
  }
}
