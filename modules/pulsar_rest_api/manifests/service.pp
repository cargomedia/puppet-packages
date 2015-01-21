class pulsar_rest_api::service {

  service {'pulsar-rest-api':
    require => Package['pulsar-rest-api'],
  }
}
