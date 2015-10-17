node default {

  host { 'www.example.com':
    ip => '127.0.0.1',
  }

  cm::reverse_proxy { 'www.example.com':
    upstream_options => {
      members => ['localhost:1337'],
      ssl => false,
    }
  }
}
