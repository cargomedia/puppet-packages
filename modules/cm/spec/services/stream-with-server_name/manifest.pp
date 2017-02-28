node default {

  class { 'cm::services::stream':
    server_name => ['example.dev'],
    port       => 443,
    ssl_cert   => template('cm/spec/spec-ssl.pem'),
    ssl_key    => template('cm/spec/spec-ssl.key'),
  }

  host { 'mock-domain-resolution':
    host_aliases => ['example.dev'],
    ip           => '127.0.0.1',
  }

}
