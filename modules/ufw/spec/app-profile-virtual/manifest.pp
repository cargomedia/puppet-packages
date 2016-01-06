node default {

  @ufw::application{ 'foo':
    app_name        => 'food',
    app_description => 'food - the foo daemon',
    app_ports       => '21,23:25/tcp|10000:15000/udp',
  }

  include 'ufw'
}
