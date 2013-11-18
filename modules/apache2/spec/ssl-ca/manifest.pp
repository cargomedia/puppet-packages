node default {

  apache2::ssl-ca {'example.com':
    content => 'foo',
  }
}
