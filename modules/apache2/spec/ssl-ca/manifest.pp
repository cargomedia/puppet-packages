node default {

  apache2::ssl_ca {'example.com':
    content => 'foo',
  }
}
