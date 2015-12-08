node default {

  service { 'my-program':
    ensure   => 'running',
    provider => $::service_provider,
  }

}
