node default {

  service { 'my-program':
    ensure   => 'stopped',
  }
}
