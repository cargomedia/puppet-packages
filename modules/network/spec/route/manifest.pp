node default {

  network::route { 'foo':
    via         => '127.0.0.2',
  }

  network::route { 'bar':
    destination => '127.9.9.6',
    via         => '127.0.0.3',
  }
}
