node default {

  service { 'my-program':
    provider => $::service_provider,
    ensure   => 'running',
  }

}
