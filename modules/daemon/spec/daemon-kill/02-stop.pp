node default {

  service { 'my-program':
    ensure   => 'stopped',
    provider => $::service_provider,
  }
}
