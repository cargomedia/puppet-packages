node default {

  network::route { 'foo':
    destination => '127.9.9.6',
    via         => '127.0.0.1'
  }
}
