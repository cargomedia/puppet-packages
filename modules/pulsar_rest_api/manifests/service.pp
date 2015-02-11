class pulsar_rest_api::service {

  service { 'pulsar-rest-api':
    enable  => true,
    require => Package['pulsar-rest-api'],
  }
}
