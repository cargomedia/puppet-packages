node default {

  ufw::application{ 'foo':
    app_name        => 'food',
    app_description => 'food - the foo daemon',
    app_ports       => '21,23:25/tcp|10000:15000/udp',
    auto_allow      => false,
  }
  ->

  ufw::rule { 'food to 10.0.0.0/8':
    app_or_port   => 'food',
    to            => '10.0.0.0/8',
    from          => '10.0.0.0/8'
  }
  ->

  ufw::rule { 'food from 127.0.0.0/8 with port 25':
    app_or_port => 25,
    protocol    => 'udp',
    from        => '127.0.0.0/8'
  }
  ->

  ufw::rule { 'food from 192.0.0.0/8 with port 23,24':
    app_or_port => '23,24',
    protocol    => 'tcp',
    from        => '192.0.0.0/8',
    to          => '190.0.0.0/8',
  }
  ->

  ufw::rule { 'food from any with port 50:60':
    app_or_port => '50:60',
    protocol    => 'tcp',
  }
  ->

  ufw::rule { 'food from any with port 100:150,200':
    app_or_port => '100:150,200',
    protocol    => 'tcp',
  }

  include 'ssh'
}
