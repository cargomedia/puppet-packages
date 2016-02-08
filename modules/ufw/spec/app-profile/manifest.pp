node default {

  ufw::application{ 'foo':
    app_name        => 'food',
    app_description => 'food - the foo daemon',
    app_ports       => '21,23:25/tcp|10000:15000/udp',
  }
  ->

  ufw::rule { 'food from 127.0.0.0/8 with port 25':
    app_or_port => 25,
    from        => '127.0.0.0/8'
  }
  ->

  ufw::rule { 'food to 10.0.0.0/8':
    app_or_port => 'food',
    to          => '10.0.0.0/8'
  }

}
